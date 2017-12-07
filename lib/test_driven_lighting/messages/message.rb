class Message
  # (Mostly) Common message attributes
  attr_reader :message

  # message: hash with string keys containing the message data.
  # MUST contain at least "message_type" => "name_of_this_message" so we know
  # which message class should handle it, though technically that's all handled
  # by MessageDispatcher before we ever construct the message
  def initialize(message)
    @message = message
  end

  def message_type; message.fetch("message_type"); end

  # NOTE: Subclass is expected to implement #process
end
