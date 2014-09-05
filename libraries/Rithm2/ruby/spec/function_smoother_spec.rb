require 'spec_helper'

describe FunctionSmoother do

  describe '#smooth' do
    subject { described_class.new(function) }
    context 'input is single peak' do
      let(:input) { [0,0,0,1,0,0,0] }

      context 'smoothing function is single peak' do
        let(:function) { Proc.new { |x| x == 0 ? 1 : 0 } }
        it 'returns input' do
          subject.smooth(input).should == input
        end
      end

      context 'smoothing function is a normal distribution' do
        let(:function) { NormalDistribution.new(mean: 0, stddev: 1) }
        it 'returns the normal distribution' do
          subject.smooth(input).zip([0.004, 0.054, 0.242, 0.399, 0.242, 0.054, 0.004]).each do |actual, expected|
            actual.should be_within(0.001).of(expected)
          end
        end
      end
    end

    context 'input is 2 peaks' do
      let(:input) { [0,0,1,0,1,0,0] }

      context 'smoothing pattern is single peak' do
        let(:function) { Proc.new { |x| x == 0 ? 1 : 0 } }
        it 'returns input' do
          subject.smooth(input).should == input
        end
      end

      context 'smoothing pattern is normal_distribution' do
        let(:function) { NormalDistribution.new(mean: 0, stddev: 1) }
        it 'returns normal_distribution padded in zeroes' do
          subject.smooth(input).zip([0.054, 0.246, 0.453, 0.484, 0.453, 0.246, 0.054]).each do |actual, expected|
            actual.should be_within(0.001).of(expected)
          end
        end
      end
    end

    context 'input is weighed values' do
      let(:input) { [0,0,1,3,2,0,0] }

      context 'smoothing pattern is single peak' do
        let(:function) { Proc.new { |x| x == 0 ? 1 : 0 } }
        it 'returns input' do
          subject.smooth(input).should == input
        end
      end

      context 'smoothing pattern is normal_distribution' do
        let(:function) { NormalDistribution.new(mean: 0, stddev: 1) }
        it 'returns normal_distribution padded in zeroes' do
          subject.smooth(input).zip([0.068, 0.413, 1.233, 1.923, 1.578, 0.650, 0.121]).each do |actual, expected|
            actual.should be_within(0.002).of(expected)
          end
        end
      end
    end

    context 'input touches edges' do
      let(:input) { [2,1,0,0,0,1,2] }

      context 'smoothing pattern is single peak' do
        let(:function) { Proc.new { |x| x == 0 ? 1 : 0 } }
        it 'returns input' do
          subject.smooth(input).should == input
        end
      end

      context 'smoothing pattern is normal_distribution' do
        let(:function) { NormalDistribution.new(mean: 0, stddev: 1) }
        it 'ignores values outside edges' do
          subject.smooth(input).zip([1.04, 0.883, 0.355, 0.126, 0.355, 0.883, 1.04]).each do |actual, expected|
            actual.should be_within(0.002).of(expected)
          end
        end
      end
    end


    context 'input is realistic with noise' do
      let(:input) { [0,0,0,0,1,5,2,8,9,2,4,1,0,0,0,0] }
      let(:output) { [0.0, 0.005, 0.076, 0.522, 1.753, 3.193, 4.493, 6.253, 6.361, 4.439, 2.843, 1.516, 0.468, 0.072, 0.005, 0.0] }

      context 'smoothing pattern is normal_distribution' do
        let(:function) { NormalDistribution.new(mean: 0, stddev: 1) }
        it 'returns normal_distribution padded in zeroes' do
          subject.smooth(input).zip(output).each do |actual, expected|
            actual.should be_within(0.002).of(expected)
          end
        end
      end
    end

  end

end
