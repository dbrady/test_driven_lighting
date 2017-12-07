require_relative '../config'
require_relative '../lib/test_driven_lighting'
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
lamp     = Lamp.new MY_LAMP_ID
receiver = Receiver.new bunny_config

receiver.listen(`whoami`) do |payload|
  puts "Receiving message with #{payload}"

  case payload['status']
  when 'fail'
    lamp.color = 'red'
  when 'pass'
    lamp.color = 'green'
  end

  hue.change! lamp
end
