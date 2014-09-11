require 'spec_helper'

describe PulseTimestampBuffer do

  subject { described_class.new(4.5) }

  it 'keeps timestamps of detected pulses within time window' do
    subject << 5.0
    subject.to_a.should == [5.0]
    subject << 5.5
    subject.to_a.should == [5.0, 5.5]
    subject << 8.5
    subject.to_a.should == [5.0, 5.5, 8.5]
    subject << 9.5
    subject.to_a.should == [5.0, 5.5, 8.5, 9.5]
    subject << 9.6
    subject.to_a.should == [5.5, 8.5, 9.5, 9.6]
  end

end
