require_relative '../../../config'
require_relative '../../test_driven_lighting'
include TestDrivenLighting

hue_config = {
  hue_ip:  HUE_IP,
  hue_api_id:  HUE_API_ID
}

bunny_config = {
  bunny_username:  BUNNY_USERNAME,
  bunny_password:  BUNNY_PASSWORD,
  bunny_host:  BUNNY_HOST
}

hue      = Hue.new hue_config
lamp1    = Lamp.new 1
receiver = Receiver.new bunny_config

receiver.listen(`whoami`) do |payload|
  puts "Receiving message with #{payload}"

  case payload['status']
  when 'fail'
    lamp1.color = 'red'
  when 'pass'
    lamp1.color = 'green'
  end

  hue.change! lamp1
end
