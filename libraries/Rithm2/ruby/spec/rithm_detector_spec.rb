require 'spec_helper'

describe RithmDetector do
  let(:beats) { [1,1,0,1,0,0,1,1] }
  let(:frequency) { 2 }
  let(:rithm) { Rithm.new(beats, frequency) }
  let(:expected_pulse_timestamps) { rithm.to_pulse_timestamps }

  subject { described_class.new(rithm) }

  describe "#valid_pulse_timestamps?" do
    it "returns true for correct pulse_timestamps" do
      subject.pulse_timestamps = expected_pulse_timestamps
      expect(subject.valid_pulse_timestamps?).to eq true
    end

    it "has valid? alias" do
      subject.pulse_timestamps = expected_pulse_timestamps
      expect(subject.valid?).to eq true
    end

    it "returns true for correct pulse_timestamps with small timing noise" do
      expected_pulse_timestamps.map! { |time| time += rand * subject.timing_margin }
      subject.pulse_timestamps = expected_pulse_timestamps
      expect(subject.valid_pulse_timestamps?).to eq true
    end

    it "returns true for correct pulse_timestamps with offset" do
      expected_pulse_timestamps.map! { |time| time += 10 }
      subject.pulse_timestamps = expected_pulse_timestamps
      expect(subject.valid_pulse_timestamps?).to eq true
    end

    it "returns true for correct pulse_timestamps with small scaling factor" do
      expected_pulse_timestamps.map! { |time| time * 1.15 }
      subject.pulse_timestamps = expected_pulse_timestamps
      expect(subject.valid_pulse_timestamps?).to eq true
    end

    it "returns true for correct pulse_timestamps with large scaling factor allowed" do
      subject.scaling_margin = 2.0
      expected_pulse_timestamps.map! { |time| time * 1.9 }
      subject.pulse_timestamps = expected_pulse_timestamps
      expect(subject.valid_pulse_timestamps?).to eq true
    end

    it "returns false for incorrect pulse_timestamps" do
      expected_pulse_timestamps[2] = 1.0
      subject.pulse_timestamps = expected_pulse_timestamps
      expect(subject.valid_pulse_timestamps?).to eq false
    end

    it "returns false for partial pulse_timestamps" do
      expected_pulse_timestamps.pop
      subject.pulse_timestamps = expected_pulse_timestamps
      expect(subject.valid_pulse_timestamps?).to eq false
    end
  end
end
