# Test Driven Lighting Notes

## TODO for MVP

* Get multicast/fanout working

## Bridges to ~~Burn~~Cross When We Get To Them
* App versioning and/or per-message versioning
  * Per-message versioning: instead of saying "you need version X.Y.Z of the app
    to even talk to me" we say "Here's a TestSuiteStart message version
    2.1". The client can say "Hey, I have a TestSuiteStart message handler
    class, but it's version 2.0, so I may miss out on some extended
    functionality." or the client could say "I only have version 1.3 of
    TestSuiteStart, so I cannot handle this message."
* Performance testing - how many ms (or us?) do we lose per message call? If
  it's more than some number, say 1-10ms, we probably don't want it to block
  example execution or it will slow down fast test suites.
* Performance testing - how many messages can we drive at the lights? Do we want
  the light client to throttle messages to the lights to something like
  2-10/sec?
* Client Configuration
  - I have these Light objects
  - On this Message, do this to this Light

## Nicetohaves / Wannados / Coolifs
* Message classes
* Message handler/parser/dispatcher (IRC client, anyone?)
* Light class
  - knows state of light (can query REST interface)
  - can delegate/collaborate with throttling messages to the lights
* Animations
  - "blink light at 2Hz for 10 seconds"
  - "change light randomly as quickly as possible for 3 seconds"
  - "do the colorloop... only faster (or slower)"
  - "flash the light's brightness"
* Change multiple lights with a single call - is this possible in the API?
  Perhaps if we make a light group?
* huepair cli scripts, like hueclear or hueoff or huereset or hueblink. E.g. if
  we hit Ctrl-C during a test run, don't leave the lights blue.

## Stuff We Need For The Demo
1. Explain the setup:
  1. David Presenting, with TMate sessions to Ashton, Brian, and DJ.
  1. Ashton and Brian are in Columbus on the LAN. They have a HUE hub and each
     have a light.
  1. I am in Utah with my HUE lights and my HUE hub. I am on the VPN.
  1. DJ is in Pittsburgh with his HUE light and his HUE hub. He is on the VPN.
  1. Handwaving: For the sake of this demonstration and for not blowing our
     budget, we are all in the same room and doing this demonstration with a
     single HUE hub, be we are ONLY sharing the hardware. Each of our laptops
     has a separate connection to the hub and none of us will be manipulating
     any lights other than our own.
  1. So to be clear, I can turn my light on and off (toggle light), and Ashton
     can turn his light on and off, and so can Brian, and so can DJ. (Each
     toggle their light)
1. Pair Test Lamps
  1. I share screens with Ashton via TMate and/or screenhero.
  1. Ashton and I sit down and start up our test monitors, our lights go green.
  1. Ashton writes a failing test, runs it on his machine, both our lights go
     blue, the test runs, the lights turn red.
  1. I write code to make the test pass, run it, both our lights go green.
  1. TA-DAA!
1. Explanation of Technology
  1. Pretty lights are fun but they're not really distributable.
  1. What makes this all possible is a messaging exchange server sitting out
     where we can hit it. Ideally this would be some hardware in-house running
     AMQP, but it doesn't have to be. There's no PHI or sensitive data going
     through here. Just tiny little messages like "Ashton started a test run" or
     "Dave's test suite finished, but there were failures."
  1. Each of us has told this messaging server what kinds of messages we're
     interested in providing, or maybe just listening to. Ashton and I were both
     providing messages about our test suites, and we were both listening for
     messages from either of our test suites.
1. Alerting
  1. Presenter plus Brian. (Consider buying an ambiance lamp for this?)
  1. This is Brian. He's about to have a bad day, but the important thing is he
     knows it and he's prepared. Brian's light is a dim yellow-orange.
  1. Show Grafana mockup with line trending upward. This poor test server is
     running out of disk space.
  1. Brian's light starts getting redder and brighter.
  1. The good news is, Brian has configured this Grafana dashboard to send
     server alerts to the message server. Again, no PHI or sensitive data, just
     tiny little messages like "disk space alert at 90%". He's also told the
     message server that he's interested in any messages from Grafana, and if
     there's a disk space alert, turn on steady at a brightness and redness
     value relative to the scarcity of the disk space. Wanna go ahead and free
     up some disk space there, Brian?
  1. Brian fiddles with a thing and the line drops off.
  1. Brian's light fades back to green and then turns off.
1. [Jenkins](https://ci.cmmint.net/view/Testing%20Tools/job/test_driven_lighting/job/send_lighting_message/)
  1. Presenter plus DJ.
  1. This is DJ. He wants to deploy some code, but our deploy process has gotten
     more and more cumbersome and asynchronous over time. He's got a PR waiting
     on Jenkins to be deployed, but he's discovered a wafer-thin change he needs
     to make. What could possibly go wrong?
  1. DJ pushes the commit.
  1. Jenkins starts running its checks; at the same time, DJ's light turns on.
  1. DJ has told the messaging server that he's interested in indicators-api
     builds, but only for this PR.
  1. DJ's light turns red.
  1. Uh-oh. Jenkins has a problem. This isn't exactly news, of course; but it's
     nice to not have to watch the build and still know it right away
  1. DJ fixes the build and pushes up the new commit.
  1. Jenkins fires back up, DJ's light turns on, the tests run, and the light
     turns green.
  1. Of course we also had to configure Jenkins to send out the message about
     the build of the PR, and to send out the message that the build was
     finished and whether or not it succeeded.

1. So... pretty lights are pretty, but... why is any of this important?
  1. Pretty lights ARE pretty, but they're really not the point.
  1. These are Active Information Radiators.
  1. We don't have to watch a system as closely now when we know the system will
     come find us if there's a problem. (I'm not suggesting you kick off a
     high-risk deploy and close your laptop; this is an additional layer of
     assurance, not an unvetted replacement.)
  1. Having the light on your desk is a real-time, physical space, active
     information indicator in both space AND time. If my test suite takes 2
     seconds, I already know my tests are fast. If it takes 15 minutes, I
     already know my tests are too slow. But if this light is blue for 45
     seconds or 90 seconds, I am presented with gentle, nag-free, real-time
     sensory input about the duration of my testing cycles. Test suite
     performance becomes observed, not just monitored. That's not something
     PagerDuty or email alerts can do, and it's not something we're honestly
     willing to do by just sitting and watching an ajax spinner. It's there, in
     the corner of our eye, letting us work on and think about other things.
  1. Red alerts can literally be red alerts, even if you have HipChat minimized
     and Outlook shut down.
  1. We're working on a Pomodoro timer for it, too.
  1. And with this clear sticker applied... (put SQL on bulb), it become a tiny
     database. See? It's SQL Lite. It doesn't store very much information, but
     check it out, you can easily upgrade the memory capacity: (Turn light
     mauve.)

(Mauve is 276deg, 31% sat, 100% val. Not sure what that would be in HSB space.)

HSL Convert says 100 Sat, 84% Lum. Normalizing H to 64k and S/L to 256 is about:

--hue 50244 --sat 255 --bri 214
