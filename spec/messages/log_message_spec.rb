require 'spec_helper'
require 'messages/log_message'

describe LogMessage do
  subject do
    LogMessage.new( {
                      'message_type' => 'log_message',
                      'content' => 'This is a log message'
                    } )
  end

  it 'implements #process' do
    expect(subject).to respond_to :process
  end

  it 'writes message content to stdout' do
    expect($stdout)
      .to receive(:puts)
           .with(/ This is a log message$/)
    subject.process
  end

  it 'writes a date and time stamp to stdout' do
    now = Time.new
    expect(Time).to receive(:new).and_return now
    date = now.strftime "%Y-%m-%d"
    time = now.strftime "%H:%M:%S"

    expect($stdout)
      .to receive(:puts)
           .with(/^#{date} #{time} /)
    subject.process
  end
end
