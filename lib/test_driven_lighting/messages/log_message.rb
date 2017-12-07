require_relative 'message'

# LogMessage - prints a message to the log (currently just whatever screen is
# running the listener)
class LogMessage < Message
  def initialize message
    super
  end

  def process
    content = message.fetch 'content'
    puts "%s %s" % [timestamp, content]
  end

  private

  def timestamp
    Time.new.strftime "%F %T"
  end
end
