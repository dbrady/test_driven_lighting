require 'yaml'
config = YAML::load_file(File.expand_path('~/.test_driven_lighting.conf'))
require_relative '../lib/test_driven_lighting'
include TestDrivenLighting

hue_config = {
  hue_ip:  config[:hue_ip],
  hue_api_id:  config[:hue_api_id]
}

hue      = Hue.new hue_config
lamp     = Lamp.new config[:my_lamp_id]
receiver = Receiver.new config[:bunny]

receiver.listen(`whoami`) do |payload|
  puts "Receiving message with #{payload}"

  case payload['status']
  when 'fail'
    lamp.color = 'red'
  when 'pass'
    lamp.color = 'green'
  when 'pending'
    lamp.color = 'yellow'
  end

  hue.change! lamp
end
