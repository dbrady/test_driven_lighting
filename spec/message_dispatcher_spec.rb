require 'spec_helper'
require 'message_dispatcher'

describe MessageDispatcher do
  let(:message) { { 'message_type' => 'fake_message' } }
  let(:message_handler) { double 'MessageHandler' }
  let(:message_class_double) { double 'MessageClass' }

  describe '#dispatch' do
    let(:fake_message_instance) { double 'FakeMessage' }
    let(:fake_message_class) { double 'FakeMessageClass' }

    before do
      subject.register_message_class 'fake_message', fake_message_class
    end

    it 'finds the registered handler and asks it to process the message' do
      expect(fake_message_class)
        .to receive(:new)
             .with(message)
             .and_return fake_message_instance

      expect(fake_message_instance)
        .to receive(:process)

      subject.dispatch(message)
    end
  end
end
