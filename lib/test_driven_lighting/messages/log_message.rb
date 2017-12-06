class LogMessage
  def dispatch(outgoing_message)
    content = outgoing_message.fetch("content")
    puts content
  end
end
