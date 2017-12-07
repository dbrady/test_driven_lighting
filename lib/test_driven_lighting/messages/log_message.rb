require 'spec_helper'
require_relative 'message'

# LogMessage - prints a message to the log (currently just whatever screen is
# running the listener)
class LogMessage < Message
  def initialize message
    super
  end

  def dispatch
    content = message.fetch 'content'
    puts content
  end
end
