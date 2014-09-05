require 'spec_helper'

describe Buffer do

  subject { described_class.new(3) }

  it 'keeps all new values when not full yet' do
    subject << 1
    subject.to_a.should == [1]
    subject << 2
    subject.to_a.should == [1,2]
    subject << 3
    subject.to_a.should == [1,2,3]
  end

  it 'automatically drops oldest value when new insertion when full' do
    subject << 1
    subject << 2
    subject << 3
    subject.to_a.should == [1,2,3]
    subject << 4
    subject.to_a.should == [2,3,4]
    subject << 5
    subject.to_a.should == [3,4,5]
  end

end
