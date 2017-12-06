require_relative '../lib/test_driven_lighting/message_dispatcher'
require_relative '../lib/test_driven_lighting/messages/log_message'

# This needs a good/better name. This class peeks at message_type in a block of
# JSON and then factories up a message class of the same type.

# request-level spec -- scope is the application (we can talk to other classes,
# but only inside our application)
describe MessageDispatcher do
  let(:message) do
    {
      'message_type' => 'log_message',
      'content' => 'This is a log message'
    }
  end

  it 'writes message content to stdout' do
    subject.register_message_class 'log_message', LogMessage
    expect($stdout).to receive(:puts).with(/This is a log message/)
    subject.dispatch message
  end

  describe '#class_for' do
    it 'returns the registered class for that name' do
      subject.register_message_class 'log_message', LogMessage
      expect(subject.class_for('log_message')).to be LogMessage
    end
  end
end
