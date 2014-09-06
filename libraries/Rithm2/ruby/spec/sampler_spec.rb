require 'spec_helper'

describe Sampler do

  describe '#sample' do
    subject { described_class.new(frequency: 8) }
    let(:function) { double }

    before do
      allow(function).to receive(:call).and_return(1,2,3)
      allow(subject).to receive(:delay_to_next_sample).and_return(0.01)
    end

    it 'builds up input time series' do
      subject.sample(function).should == 1
      subject.sample(function).should == 2
      subject.sample(function).should == 3
    end

  end

end

describe 'Sampler Live test', slow: true do

  subject { Sampler.new(frequency: 8) }
  let(:function) { double }

  before do
    allow(function).to receive(:call).and_return(1,2,3,4,5,6,7,8)
  end

  it 'samples the provided function at requested frequency, blocks if too soon' do
    array = []
    start_time = Time.now
    7.times do
      array << subject.sample(function)
      puts 'Sample!'
    end

    end_time = Time.now

    (end_time.to_f - start_time.to_f).should be_within(0.1).of(0.75)
    array.should == [1,2,3,4,5,6,7]
  end

end
