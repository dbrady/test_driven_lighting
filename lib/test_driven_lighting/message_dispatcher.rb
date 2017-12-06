class MessageDispatcher
  attr_reader :message_classes
  def initialize
    # message_classes contains "class_name" => ClassName
    @message_classes = {}
  end

  def register_message_class(name, klass)
    # screw trying to upcase and snake case and pretend to be rails WE'RE NOT
    # RAILS SO STOP TRYING
    message_classes[name] = klass
  end

  def dispatch(outgoing_message)
    klass = class_for outgoing_message.fetch("message_type")
    klass.new(outgoing_message).dispatch
  end

  def class_for(class_name)
    message_classes.fetch class_name
  end
end
