require 'spec_helper'
require 'hue'
require 'lamp'
require 'webmock/rspec'
WebMock.disable_net_connect!

describe Hue do
  let(:hue) {Hue.new({:hue_ip => '1.2.3.4', :hue_api_id => 'supersecretapiid'})}
  let(:lamp) {Lamp.new(1)}

  it 'initializes by setting the hue_ip and hue_api_id' do
    expect(hue.hue_ip).to eq '1.2.3.4'
    expect(hue.hue_api_id).to eq 'supersecretapiid'
  end

  describe '#change!' do
    it 'PUTs lamp settings to the bulb' do
      stub_request(:put, "http://1.2.3.4/api/supersecretapiid/lights/1/state")
      expect(hue.change!(lamp)).to have_requested(:put, "http://1.2.3.4/api/supersecretapiid/lights/1/state" )
    end
  end
end
