require 'spec_helper'
require 'lamp'

describe Lamp do
  let(:lamp) {Lamp.new(1)}

  attributes = [:hue, :saturation, :brightness, :is_on, :transition_time, :colors, :id]
  attributes.each do |attribute|
    it "has a settable '#{attribute}' attribute'" do
      expect(lamp).to respond_to attribute
      lamp.send("#{attribute}=",123)
      expect(lamp.send(attribute)).to eq 123
    end
  end

  it 'has a default numeric hue' do
    expect(lamp.hue.class).to eq Fixnum
  end

  it 'has a default numeric saturation' do
    expect(lamp.saturation.class).to eq Fixnum
  end

  it 'has a default numeric brightness' do
    expect(lamp.brightness.class).to eq Fixnum
  end

  it 'has a default boolean is_on' do
    expect(lamp.is_on).to eq true
  end

  it 'has a default numeric transition_time' do
    expect(lamp.transition_time.class).to eq Fixnum
  end

  it 'has a default hash of colors' do
    expect(lamp.colors.class).to eq Hash
    expect(lamp.colors.first[1].keys).to include 'hue'
    expect(lamp.colors.first[1].keys).to include 'saturation'
  end

  it 'can set color using english words' do
    lamp.color = 'mauve'
    expect(lamp.hue).to eq 52000
    expect(lamp.saturation).to eq 150
  end

end
