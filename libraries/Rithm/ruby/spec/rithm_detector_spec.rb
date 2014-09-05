require 'spec_helper'

describe RithmDetector do
  let(:beats) { [1,1,0,1,0,0,1,1] }
  let(:frequency) { 2 }
  let(:rithm) { Rithm.new(beats, frequency) }
  let(:expected_pulse_time_series) { rithm.to_pulse_time_series }

  subject { described_class.new(rithm) }

  describe "#valid_pulse_time_series?" do
    it "returns true for correct pulse_time_series" do
      subject.set_pulse_time_series = expected_pulse_time_series
      expect(subject.valid_pulse_time_series?).to eq true
    end

    it "has valid? alias" do
      subject.set_pulse_time_series = expected_pulse_time_series
      expect(subject.valid_pulse_time_series?).to eq true
    end

    it "returns true for correct pulse_time_series with small timing noise" do
      expected_pulse_time_series.map! { |time| time += rand * subject.margin }
      subject.set_pulse_time_series = expected_pulse_time_series
      expect(subject.valid_pulse_time_series?).to eq true
    end

    it "returns true for correct pulse_time_series with offset" do
      expected_pulse_time_series.map! { |time| time += 10 }
      subject.set_pulse_time_series = expected_pulse_time_series
      expect(subject.valid_pulse_time_series?).to eq true
    end

    it "returns false for incorrect pulse_time_series" do
      expected_pulse_time_series[2] = 1.0
      subject.set_pulse_time_series = expected_pulse_time_series
      expect(subject.valid_pulse_time_series?).to eq false
    end

    it "returns false for partial pulse_time_series" do
      expected_pulse_time_series.pop
      subject.set_pulse_time_series = expected_pulse_time_series
      expect(subject.valid_pulse_time_series?).to eq false
    end

    it "returns true for correct pulse_time_series with prepended time stamps" do
      expected_pulse_time_series.unshift(1)
      subject.set_pulse_time_series = expected_pulse_time_series
      expect(subject.valid_pulse_time_series?).to eq true
    end
  end

  describe '#detect_beat!' do
    it 'adds timestamp to pulse_time_series' do
      subject.detect_beat!
      subject.detect_beat!
      expect(subject.pulse_time_series.size).to eq 2
    end

    it 'it truncates timeseries of larger then expected_pulse_time_series' do
      10.times { subject.detect_beat! }
      expect(subject.pulse_time_series.size).to eq 5
    end
  end
end


describe 'RithmDetector Live test', slow: true do

  describe "play and detect rithm" do
    let!(:rithm)                { Rithm.new([1,1,1,1,0,1,0,1,0,1,1,1],20) }
    let!(:wrong_rithm)          { Rithm.new([1,1,1,1,0,1,0,1,1,0,1,1],20) }
    let!(:eventual_rithm) { Rithm.new([1,0,1,1,1,1,1,0,1,0,1,0,1,1,1],20) }
    let!(:rithm_detector) { RithmDetector.new(rithm) }

    it "plays SOS and matches valid on last beat" do
      rithm.play do
        rithm_detector.detect_beat!
        #puts "Beat! rithm matched? #{rithm_detector.valid?}"
      end
      expect(rithm_detector.valid?).to eq true
    end

    it "eventually plays SOS and matches valid on last beat" do
      eventual_rithm.play do
        rithm_detector.detect_beat!
        #puts "Beat! rithm matched? #{rithm_detector.valid?}"
      end
      expect(rithm_detector.valid?).to eq true
    end

    it "plays wrong rithm and never matches" do
      wrong_rithm.play do
        rithm_detector.detect_beat!
        #puts "Beat! rithm matched? #{rithm_detector.valid?}"
      end
      expect(rithm_detector.valid?).to eq false
    end
  end

end
