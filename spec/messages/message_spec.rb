require 'spec_helper'
require 'messages/message.rb'

describe Message do
  subject { Message.new "message_type" => "none" }

  describe "#process" do
    it "is abstract and has no default implementation" do
      expect { subject.process }.to raise_error NoMethodError, /undefined method `process'/
    end
  end
end
