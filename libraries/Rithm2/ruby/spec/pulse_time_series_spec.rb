require 'spec_helper'

describe PulseTimeSeries do

  describe "#to_relative_pulse_timestamps" do
    subject { described_class.new([1,1,0,1,0,0,1,1],2) }

    it "returns the pulse_timestamp of the pulses" do
      expect(subject.to_relative_pulse_timestamps).to eq [0.0, 0.5, 1.5, 3.0, 3.5]
    end
  end

  describe "#to_absolute_pulse_timestamps" do
    subject { described_class.new([1,1,0,1,0,0,1,1],2) }
    let(:pulse_timestamps) { [0.0, 0.5, 1.5, 3.0, 3.5] }
    let(:current_time) { Time.now.to_f }

    it "returns the pulse_timestamp of the pulses" do
      [
        pulse_timestamps,
        subject.to_absolute_pulse_timestamps,
      ].transpose.each do |relative_timestamp, absolute_timestamp|
        absolute_timestamp.should be_within(0.1).of(current_time - 3.5 + relative_timestamp)
      end
    end
  end

  describe ".absolute_to_relative_pulse_timestamps" do
    let(:pulse_timestamps) { [5.5, 6, 8, 9.5] }
    it "removes the offset" do
      described_class.absolute_to_relative_pulse_timestamps(pulse_timestamps).should == [0, 0.5, 2.5, 4]
    end
  end

  describe ".relative_to_absolute_timestamps" do
    let(:pulse_timestamps) { [0, 0.5, 2.5, 4] }
    let(:current_time) { Time.now.to_f }

    it "adds the offset" do
      [
        pulse_timestamps,
        described_class.relative_to_absolute_timestamps(pulse_timestamps),
      ].transpose.each do |relative_timestamp, absolute_timestamp|
        absolute_timestamp.should be_within(0.1).of(current_time - 4 + relative_timestamp)
      end
    end
  end

end
