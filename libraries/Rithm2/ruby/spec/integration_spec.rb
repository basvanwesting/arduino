require 'spec_helper'

describe 'Integration of all elements', slow: true do

  describe "play and detect rithm" do
    let(:rithm_frequency)   { 11 }
    let(:rithm_interval)    { rithm.interval }
    let(:sample_frequency)  { rithm_frequency * 10 }
    let(:number_of_samples) { sample_frequency / rithm_frequency * rithm.pulses.size }
    let(:smoother_function) { NormalDistribution.new(mean: 0, stddev: 1) }
    let(:pulse_detection_low)  { 9  }
    let(:pulse_detection_high) { 11 }

    let(:rithm)            { Rithm.new([1,1,1,1,0,1,0,1,0,1,1,1],rithm_frequency) }
    let(:wrong_rithm)      { Rithm.new([1,1,1,1,0,1,0,1,1,0,1,1],rithm_frequency) }
    let(:eventual_rithm)   { Rithm.new([1,0,1,1,1,1,1,0,1,0,1,0,1,1,1],rithm_frequency) }

    let(:sampler)         { Sampler.new(frequency: sample_frequency) }
    let(:buffer)          { Buffer.new(number_of_samples) }
    let(:smoother)        { FunctionSmoother.new(smoother_function) }
    let(:pulse_detection) { PulseDetection.new(low: pulse_detection_low, high: pulse_detection_high) }
    let(:rithm_detector)   { RithmDetector.new(rithm) }

    before do
      puts "rithm frequency: #{rithm_frequency}"
      puts "sample frequency: #{sample_frequency}"
      puts "number of samples: #{number_of_samples}"
      puts "rithm interval: #{rithm_interval}"
    end

    it "plays SOS and matches valid on last beat" do
      play_function_proc = rithm.play_function_proc
      number_of_samples.times do
        buffer << sampler.sample(play_function_proc)
      end

      smoothed_buffer = smoother.smooth(buffer.to_a)

      pulses = pulse_detection.parse(smoothed_buffer)

      puts %w(buffer smoothed pulses).join(';')
      buffer.to_a.zip(smoothed_buffer, pulses).each do |b,s,p|
        puts [b.round,s.round,p].join(';')
      end

      pulse_timestamps = PulseTimeSeries.new(pulses, sample_frequency).to_pulse_timestamps
      puts pulse_timestamps

      puts rithm_detector.allowed_time_serie_ranges

      rithm_detector.pulse_timestamps = pulse_timestamps
      expect(rithm_detector.valid?).to eq true
    end

    xit "eventually plays SOS and matches valid on last beat" do
      eventual_rithm.play do
        rithm_detector.detect_beat!
        #puts "Beat! rithm matched? #{rithm_detector.valid?}"
      end
      expect(rithm_detector.valid?).to eq true
    end

    xit "plays wrong rithm and never matches" do
      wrong_rithm.play do
        rithm_detector.detect_beat!
        #puts "Beat! rithm matched? #{rithm_detector.valid?}"
      end
      expect(rithm_detector.valid?).to eq false
    end
  end

end
