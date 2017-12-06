require_relative 'message'

class LogMessage < Message
  def initialize(message)
    super
  end

  def dispatch
    content = message.fetch("content")
    puts content
  end
end
