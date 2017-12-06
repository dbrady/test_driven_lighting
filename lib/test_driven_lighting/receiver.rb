require 'bunny'
require 'json'

STDOUT.sync = true

class Receiver
  def initialize(config)
    @connection = Bunny.new("amqp://#{config[:bunny_username]}:#{config[:bunny_password]}@#{config[:bunny_host]}").start
    @channel = @connection.create_channel
    @exchange = @channel.fanout('lighting.messages')
  end

  def listen(queue_name, &block)
    puts 'listening for light messages...'
    @channel.queue(queue_name, :auto_delete => true).bind(@exchange).subscribe do |delivery_info, metadata, payload|
      yield JSON.parse(payload)
    end
    while true
      sleep 10
    end
  end
end


