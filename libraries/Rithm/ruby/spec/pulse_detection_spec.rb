require 'spec_helper'

describe PulseDetection do

  context '#parse' do
    subject { described_class.new(low: 3, high: 5) }

    it 'detect a pulse if the low high boundary is touched or crossed' do
      subject.parse([4,5,6])
      subject.parsed_input.should == [0,1,0]
    end

    it 'does not detect new pulse if already high' do
      subject.parse([4,5,6,7])
      subject.parsed_input.should == [0,1,0,0]
    end

    it 'does not detect new pulse if not reset by low' do
      subject.parse([4,5,4,7])
      subject.parsed_input.should == [0,1,0,0]
    end

    it 'does detect new pulse if reset by low' do
      subject.parse([4,5,4,7,2,4,5,6])
      subject.parsed_input.should == [0,1,0,0,0,0,1,0]
    end
  end

  context '#pulse_detected?' do
    it 'returns true if pulse in middle of parsed input (even)' do
      subject.parsed_input = [0,0,0,1,0,0]
      subject.pulse_detected?.should == true
    end

    it 'returns true if pulse in middle of parsed input (odd)' do
      subject.parsed_input = [0,0,1,0,0]
      subject.pulse_detected?.should == true
    end

    it 'returns false if pulse not in middle of parsed input (even)' do
      subject.parsed_input = [1,1,1,0,1,1]
      subject.pulse_detected?.should == false
    end

    it 'returns false if pulse not in middle of parsed input (odd)' do
      subject.parsed_input = [1,1,0,1,1]
      subject.pulse_detected?.should == false
    end
  end

end
