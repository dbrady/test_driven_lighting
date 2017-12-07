require 'spec_helper'
require 'messages/message.rb'

describe Message do
  subject { Message.new 'message_type' => 'none' }

  describe '#message_type' do
    it 'returns the message type string' do
      expect(subject.message_type).to eq 'none'
    end
  end

  describe '#process' do
    it 'is abstract and has no default implementation' do
      expect { subject.process }.to raise_error NoMethodError, /`process'/
    end
  end
end
