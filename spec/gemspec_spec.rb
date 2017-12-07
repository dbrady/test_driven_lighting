require 'spec_helper'

describe 'gem specification' do
  # because I'm OCD
  let(:gemspec_file) { File.join(File.dirname(__FILE__), '../test_driven_lighting.gemspec') }
  let(:lines) { IO.readlines(gemspec_file).map(&:chomp) }

  describe 'runtime dependency section' do
    subject { lines.grep /add_dependency/ }

    it 'has a version for every gem' do
      expect(subject.all? {|line| line =~ /~>/}).to be_truthy
    end

    it 'is in order' do
      expect(subject).to eq subject.sort
    end
  end

  describe 'development dependency section' do
    subject { lines.grep /add_development_dependency/ }

    it 'has a version for every gem' do
      expect(subject.all? {|line| line =~ /~>/}).to be_truthy
    end

    it 'is in order' do
      expect(subject).to eq subject.sort
    end
  end
end
