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
           .with('This is a log message')
    subject.process
  end
end
