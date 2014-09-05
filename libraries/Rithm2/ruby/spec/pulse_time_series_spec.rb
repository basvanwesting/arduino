require 'spec_helper'

describe PulseTimeSeries do

  describe "#to_pulse_timestamps" do
    subject { described_class.new([1,1,0,1,0,0,1,1],2) }

    it "returns the pulse_timestamp of the pulses" do
      expect(subject.to_pulse_timestamps).to eq [0.0, 0.5, 1.5, 3.0, 3.5]
    end
  end

end
