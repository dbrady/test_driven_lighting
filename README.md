# Test Driven Lighting

## Overview
Red / Green / _Refractor!_ Share and control HUE lights with your remote pairing
partner as you run your tests.

![green_light](https://user-images.githubusercontent.com/28605/33732794-8fb979e6-db55-11e7-9228-adb195e2aac3.jpg)

Philips HUE lights can be controlled over wifi. It's pretty trivial to make your
test suite change your lights to be red or green (or blue or yellow or anything)
...as long as you controlling your own lights over your own wifi.

![red_light](https://user-images.githubusercontent.com/28605/33732797-91ecf72e-db55-11e7-83af-088091ef926e.jpg)

But what if you are remote pairing, and you run your tests on your partner's
machine? Wouldn't you want your lights to still update?

What if you _both_ had HUE lights for watching your tests run?

## Installation

`#glhf`

TL;DR Grab Dave or Ashton or DJ or Brian and we can help you. Or just see how
far you get with this:

* **Prerequisites**
  * If you have HUE lights, you need them set up and working, and you'll need to
    know your HUE API id and the IP address of your HUE hub.
  * You'll need a RabbitMQ server running somewhere, and you'll need the host,
    username and password to connect to that.
* **1. Get Stuff**. Clone this repo and `bundle install`. You could ALSO just
  `gem install test_driven_lighting`, but you won't have an example config file
  to start from. Your call.
* **2: Set Up Your Config File**. Clone this repo and copy
  examples/example_config.yml to ~/.test_driven_lighting.conf. Edit the file and
  fill in your HUE settings and your RabbitMQ settings in the bunny config
  section.
* **3: Start the Listener**. _If your partner has HUE lights and you do not, you
  can skip this step._ Just run `tdl-pairing-start` in its own terminal
  window. Leave this window open and leave the program running. If all is set up
  correctly, it will listen for events from the RabbitMQ server and change your
  light(s) accordingly.
* **4: Test Your Listener**. Run `tdl-test-lighting` while you have the listener
  running. (And/or after your pair has their listener running.) It will go
  through the run/fail/pending/pass light stages and leave the lights green.
* **5: Run Your Specs With -f LightingFormatter**. That's it--you're all set!

```bash
gem install test_driven_lighting

```


## Running Tests

```bash
bundle exec rspec spec -f LightingFormatter
#=> {'color':'green','type':'test'}`
```

Include the gem
```
gem 'test_driven_lighting'
```

Example Receiver Code
```
require 'test_driven_lighting'
include TestDrivenLighting

hue_config = { :hue_ip => '<your_hue_ip>',
               :hue_api_id => '<your_hue_api_id>' }
bunny_config = { :bunny_username => '<bunny_username>',
                 :bunny_password =>'<bunny_password>',
                 :bunny_host => '<bunny_host>'}

hue = Hue.new(hue_config)
lamp = Lamp.new(1)
receiver = Receiver.new(bunny_config)

receiver.listen(`whoami`) do |payload|
    puts "setting bulbs using #{payload}..."
    case payload['status']
    when 'fail'
      lamp.color = 'red'
    when 'pending'
      lamp.color = 'yellow'
    when 'pass'
      lamp.color = 'green'
    end
    hue.change!(lamp)
end

```

Example Sender Code
```
require 'test_driven_lighting'
include TestDrivenLighting

bunny_config = { :bunny_username => '<bunny_username>',
                 :bunny_password =>'<bunny_password>',
                 :bunny_host => '<bunny_host>'}

sender = Sender.new(bunny_config)
sender.message_send("fail","test")
sender.message_send("pass","test")
sender.message_send("fail","suite")
sender.close_connection
```

# TODO:

- [ ] MiniTest Formatter
- [ ] MiniTest Pride Formatter - Photosensitive Epilepsy FTW
- [ ] Test::Unit Formatter

# Database

Test Driven Lighting does not require any database, but of course we recommend
using a SQL Light database. If you've got a magic marker it only takes about ten
seconds to set up.

![sqlite_database](https://user-images.githubusercontent.com/28605/33732394-5e9ded84-db54-11e7-8851-a3bb214baba5.jpg)

Just make sure it's the right color--[I hear mauve has the most RAM.](http://dilbert.com/strip/1995-11-17)

![See? More RAM.](https://user-images.githubusercontent.com/28605/33732397-60ef1e28-db54-11e7-8abd-8efe5a9f093c.jpg)
