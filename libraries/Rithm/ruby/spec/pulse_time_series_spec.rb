require 'spec_helper'

describe PulseTimeSeries do

  subject { described_class.new([0,1,2]) }

  it "behaves like an array" do
    subject.size.should == 3
    subject.first.should == 0
    subject.shift.should == 0
    subject.shift.should == 1
    subject.first.should == 2
  end

  it "has fubar" do
    subject.fubar.should == '[0, 1, 2]'
  end

  describe "#to_input_time_series" do

    context 'defaults frequency = 1, stddev = 0' do
      it 'returns the input_time_series' do
        subject.to_input_time_series.should == [
          [0.0, 1.0],
          [1.0, 1.0],
          [2.0, 1.0],
        ]
      end
    end

    context 'defaults frequency = 4, stddev = 0' do
      it 'returns the input_time_series' do
        subject.to_input_time_series(frequency: 4).should == [
          [0.0,  1.0],
          [0.25, 0.0],
          [0.5,  0.0],
          [0.75, 0.0],
          [1.0,  1.0],
          [1.25, 0.0],
          [1.5,  0.0],
          [1.75, 0.0],
          [2.0,  1.0],
        ]
      end
    end

    context 'defaults frequency = 1, stddev = 0.5' do
      subject { described_class.new([0, 4, 8]) }
      let(:expected) do
        [
          [0.0, 0.7978],
          [1.0, 0.1079],
          [2.0, 0.0005],
          [3.0, 0.1079],
          [4.0, 0.7978],
          [5.0, 0.1079],
          [6.0, 0.0005],
          [7.0, 0.1079],
          [8.0, 0.7978],
        ]
      end

      it 'returns the input_time_series' do
        actual = subject.to_input_time_series(frequency: 1, stddev: 0.5)
        [actual, expected].transpose.each do |(actual_timestamp, actual_value), (expected_timestamp, expected_value)|
          actual_timestamp.should == expected_timestamp
          actual_value.should be_within(0.0002).of(expected_value)
        end
      end
    end

  end

end
