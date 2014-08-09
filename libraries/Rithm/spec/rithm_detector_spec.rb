require 'spec_helper'

describe RithmDetector do
  let(:beats) { [1,1,0,1,0,0,1,1] }
  let(:delay) { 0.5 }
  let(:rithm) { Rithm.new(beats, delay) }
  let(:expected_time_series) { rithm.to_time_series }

  subject { described_class.new(rithm) }

  describe "#valid_time_series?" do
    it "returns true for correct time_series" do
      subject.set_time_series = expected_time_series
      expect(subject.valid_time_series?).to eq true
    end

    it "has valid? alias" do
      subject.set_time_series = expected_time_series
      expect(subject.valid_time_series?).to eq true
    end

    it "returns true for correct time_series with small timing noise" do
      expected_time_series.map! { |time| time += rand * subject.margin }
      subject.set_time_series = expected_time_series
      expect(subject.valid_time_series?).to eq true
    end

    it "returns true for correct time_series with offset" do
      expected_time_series.map! { |time| time += 10 }
      subject.set_time_series = expected_time_series
      expect(subject.valid_time_series?).to eq true
    end

    it "returns false for incorrect time_series" do
      expected_time_series[2] = 1.0
      subject.set_time_series = expected_time_series
      expect(subject.valid_time_series?).to eq false
    end

    it "returns false for partial time_series" do
      expected_time_series.pop
      subject.set_time_series = expected_time_series
      expect(subject.valid_time_series?).to eq false
    end

    it "returns true for correct time_series with prepended time stamps" do
      expected_time_series.unshift(1)
      subject.set_time_series = expected_time_series
      expect(subject.valid_time_series?).to eq true
    end
  end

  describe '#detect_beat!' do
    it 'adds timestamp to time_series' do
      subject.detect_beat!
      subject.detect_beat!
      expect(subject.time_series.size).to eq 2
    end

    it 'it truncates timeseries of larger then expected_time_series' do
      10.times { subject.detect_beat! }
      expect(subject.time_series.size).to eq 5
    end
  end
end


