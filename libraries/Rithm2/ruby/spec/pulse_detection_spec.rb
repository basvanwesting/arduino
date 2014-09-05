require 'spec_helper'

describe PulseDetection do

  subject { described_class.new(low: 3, high: 5) }

  it 'detect a pulse if the low high boundary is touched or crossed' do
    subject.parse([4,5,6]).should == [0,1,0]
  end

  it 'does not detect new pulse if already high' do
    subject.parse([4,5,6,7]).should == [0,1,0,0]
  end

  it 'does not detect new pulse if not reset by low' do
    subject.parse([4,5,4,7]).should == [0,1,0,0]
  end

  it 'does detect new pulse if reset by low' do
    subject.parse([4,5,4,7,2,4,5,6]).should == [0,1,0,0,0,0,1,0]
  end

end
