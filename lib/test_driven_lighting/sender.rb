require 'json'
require 'bunny'

class Sender
  def initialize config
    @connection = Bunny.new("amqp://#{config[:bunny_username]}:#{config[:bunny_password]}@#{config[:bunny_host]}").start
    @channel = @connection.create_channel
    @exchange = @channel.fanout('lighting.messages')
  end

  def message_send status, type
    message = Hash status: status, type: type
    @exchange.publish message.to_json
  end

  def close_connection
    @connection.close
  end
end
