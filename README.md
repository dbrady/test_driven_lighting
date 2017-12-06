# Test Driven Lighting
hue bulb test driven lighting

Running Tests:

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
