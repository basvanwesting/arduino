require 'spec_helper'

describe NormalDistribution do

  context 'mean: 0, stddev: 1' do
    subject { described_class.new(mean: 0, stddev: 1) }

    it 'behaves' do
      subject.call(-2).should be_within(0.002).of(0.054)
      subject.call(-1).should be_within(0.002).of(0.24)
      subject.call(0).should  be_within(0.002).of(0.4)
      subject.call(1).should  be_within(0.002).of(0.24)
      subject.call(2).should  be_within(0.002).of(0.054)
    end
  end

  context 'mean: 0, stddev: 0.1' do
    subject { described_class.new(mean: 0, stddev: 0.5) }

    it 'behaves' do
      subject.call(-2).should be_within(0.00002).of(0.00026)
      subject.call(-1).should be_within(0.002).of(0.108)
      subject.call(0).should  be_within(0.002).of(0.798)
      subject.call(1).should  be_within(0.002).of(0.108)
      subject.call(2).should  be_within(0.00002).of(0.00026)
    end
  end

  context 'mean: 1, stddev: 1' do
    subject { described_class.new(mean: 1, stddev: 1) }

    it 'behaves' do
      subject.call(-1).should be_within(0.002).of(0.054)
      subject.call(0).should be_within(0.002).of(0.24)
      subject.call(1).should  be_within(0.002).of(0.4)
      subject.call(2).should  be_within(0.002).of(0.24)
      subject.call(3).should  be_within(0.002).of(0.054)
    end
  end

  context 'stddev: 0' do
    subject { described_class.new(mean: 0, stddev: 0) }

    it 'behaves' do
      subject.call(-2).should == 0.0
      subject.call(-1).should == 0.0
      subject.call(0).should  == 1.0
      subject.call(1).should  == 0.0
      subject.call(2).should  == 0.0
    end

  end

end
