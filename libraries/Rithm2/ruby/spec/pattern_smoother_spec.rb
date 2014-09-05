require 'spec_helper'

describe PatternSmoother do

  describe '#pattern_index_offsets' do
    subject { described_class.new(pattern) }

    context 'pattern size is 1' do
      let(:pattern) { [1] }
      it 'returns the pattern index offset' do
        subject.pattern_index_offsets.should == [0]
      end
    end

    context 'pattern size is odd (3)' do
      let(:pattern) { [1,1,1] }
      it 'returns the pattern index offset' do
        subject.pattern_index_offsets.should == [-1,0,1]
      end
    end

    context 'pattern size is odd (5)' do
      let(:pattern) { [1,1,1,1,1] }
      it 'returns the pattern index offset' do
        subject.pattern_index_offsets.should == [-2,-1,0,1,2]
      end
    end

    context 'pattern size is even (4)' do
      let(:pattern) { [1,1,1,1] }
      it 'returns the pattern index offset' do
        subject.pattern_index_offsets.should == [-1,0,1,2]
      end
    end
  end

  describe '#smooth' do
    subject { described_class.new(pattern) }

    context 'input is single peak' do
      let(:input) { [0,0,0,1,0,0,0] }

      context 'smoothing pattern is single peak' do
        let(:pattern) { [1] }
        it 'returns input' do
          subject.smooth(input).should == input
        end
      end

      context 'smoothing pattern is a block' do
        let(:pattern) { [1,1,1] }
        it 'returns block padded in zeroes' do
          subject.smooth(input).should == [0,0,1,1,1,0,0]
        end
      end

      context 'smoothing pattern is normal_distribution' do
        let(:pattern) { [0.054, 0.24, 0.4, 0.24, 0.054] }
        it 'returns normal_distribution padded in zeroes' do
          subject.smooth(input).should == [0, 0.054, 0.24, 0.4, 0.24, 0.054, 0]
        end
      end
    end

    context 'input is 2 peaks' do
      let(:input) { [0,0,1,0,1,0,0] }

      context 'smoothing pattern is single peak' do
        let(:pattern) { [1] }
        it 'returns input' do
          subject.smooth(input).should == input
        end
      end

      context 'smoothing pattern is a block' do
        let(:pattern) { [1,1,1] }
        it 'returns block padded in zeroes' do
          subject.smooth(input).should == [0,1,1,2,1,1,0]
        end
      end

      context 'smoothing pattern is normal_distribution' do
        let(:pattern) { [0.054, 0.24, 0.4, 0.24, 0.054] }
        it 'returns normal_distribution padded in zeroes' do
          subject.smooth(input).should == [0.054, 0.24, 0.454, 0.48, 0.454, 0.24, 0.054]
        end
      end
    end

    context 'input is weighed values' do
      let(:input) { [0,0,1,3,2,0,0] }

      context 'smoothing pattern is single peak' do
        let(:pattern) { [1] }
        it 'returns input' do
          subject.smooth(input).should == input
        end
      end

      context 'smoothing pattern is a block' do
        let(:pattern) { [1,1,1] }
        it 'returns block padded in zeroes' do
          subject.smooth(input).should == [0,1,4,6,5,2,0]
        end
      end

      context 'smoothing pattern is normal_distribution' do
        let(:pattern) { [0.054, 0.24, 0.4, 0.24, 0.054] }
        it 'returns normal_distribution padded in zeroes' do
          subject.smooth(input).zip([0.054, 0.402, 1.228, 1.920, 1.574, 0.642, 0.108]).each do |actual, expected|
            actual.should be_within(0.002).of(expected)
          end
        end
      end
    end

    context 'input touches edges' do
      let(:input) { [2,1,0,0,0,1,2] }

      context 'smoothing pattern is single peak' do
        let(:pattern) { [1] }
        it 'returns input' do
          subject.smooth(input).should == input
        end
      end

      context 'smoothing pattern is a block' do
        let(:pattern) { [1,1,1] }
        it 'ignores values outside edges' do
          subject.smooth(input).should == [3.0, 3.0, 1.0, 0.0, 1.0, 3.0, 3.0]
        end
      end

      context 'smoothing pattern is normal_distribution' do
        let(:pattern) { [0.054, 0.24, 0.4, 0.24, 0.054] }
        it 'ignores values outside edges' do
          subject.smooth(input).zip([1.04, 0.88, 0.348, 0.108, 0.348, 0.88, 1.04]).each do |actual, expected|
            actual.should be_within(0.002).of(expected)
          end
        end
      end
    end

    context 'input is realistic with noise' do
      let(:input) { [0,0,0,0,1,5,2,8,9,2,4,1,0,0,0,0] }
      let(:output) { [0.0, 0.0, 0.054, 0.51, 1.708, 3.152, 4.46, 6.218, 6.324, 4.406, 2.806, 1.468, 0.456, 0.054, 0.0, 0.0] }

      context 'smoothing pattern is normal_distribution' do
        let(:pattern) { [0.054, 0.24, 0.4, 0.24, 0.054] }
        it 'returns normal_distribution padded in zeroes' do
          subject.smooth(input).zip(output).each do |actual, expected|
            actual.should be_within(0.002).of(expected)
          end
        end
      end
    end

  end

end
