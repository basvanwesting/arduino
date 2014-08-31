require 'spec_helper'

describe InputTimeSeries do

  describe 'max_length' do
    subject { described_class.new([]) }

    it 'auto truncates after insert if max length is exceeded' do
      subject.max_length = 3
      subject.should == []
      subject << 1
      subject.should == [1]
      subject << 2
      subject.should == [1,2]
      subject << 3
      subject.should == [1,2,3]
      subject << 4
      subject.should == [2,3,4]
      subject << 'a'
      subject.should == [3,4,'a']
    end

  end
end
