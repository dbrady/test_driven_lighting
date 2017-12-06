require 'json'
require 'faraday'

class Hue
  attr_accessor :hue_ip, :hue_api_id

  def initialize config
    @hue_ip     = config[:hue_ip]
    @hue_api_id = config[:hue_api_id]
  end

  def change! lamp
    data = {
        :on             => lamp.is_on,
        :bri            => lamp.brightness,
        :sat            => lamp.saturation,
        :hue            => lamp.hue,
        :transitiontime => lamp.transition_time
    }.to_json

    connection = Faraday.new("http://#{@hue_ip}")

    connection.put("/api/#{@hue_api_id}/lights/#{lamp.id}/state") do |request|
      request.headers['Content-Type'] = 'application/json'
      request.headers['Accept'] = 'application/json'
      request.body = data
    end
  end
end
