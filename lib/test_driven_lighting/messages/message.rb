class Message
  # (Mostly) Common message attributes
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def message_type;  message.fetch["message_type"]; end

  # message: hash with string keys containing the message data.
  # MUST contain at least "message_type" => "name_of_this_message" so we know
  # which message class should handle it
  #
  # NOTE: Subclass is expected to implement #process
  #
  # I was going to raise NotImplementedError here but
  # http://chrisstump.online/2016/03/23/stop-abusing-notimplementederror/ has
  # convinced me to stop doing this entirely. TL;DR NotImplementedError means
  # your PLATFORM does not support a feature of the language. Child classes in
  # Ruby not implementing an abstract method should be handled by our good
  # friend NoMethodError.
end
