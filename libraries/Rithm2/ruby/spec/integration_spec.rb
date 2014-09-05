require 'spec_helper'

describe 'Integration of all elements', slow: true do

  describe "play and detect rithm" do
    let(:rithm_frequency)   { 11 }
    let(:rithm_interval)    { rithm.interval }
    let(:sample_frequency)  { rithm_frequency * 10 }
    let(:sample_interval)   { sampler.interval }
    let(:rithm_duration)    { rithm.pulses.size * rithm_interval }
    let(:sample_duration)   { number_of_samples * sample_interval }
    let(:number_of_samples) { (rithm_duration / sample_interval).to_i }
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
    let(:rithm_detector)  { RithmDetector.new(rithm) }

    before do
      puts "rithm frequency: #{rithm_frequency}"
      puts "rithm interval: #{rithm_interval}"
      puts "sample frequency: #{sample_frequency}"
      puts "sample interval: #{sample_interval}"
      puts "rithm_duration: #{rithm_duration}"
      puts "sample_duration: #{sample_duration}"
      puts "number of samples: #{number_of_samples}"
      puts "rithm_detector timing_margin: #{rithm_detector.timing_margin}"
      puts "rithm_detector scaling_margin: #{rithm_detector.scaling_margin}"
    end

    it "plays SOS and matches valid on last beat" do
      play_function_proc = rithm.play_function_proc
      number_of_samples.times do
        buffer << sampler.sample(play_function_proc)
      end

      smoothed_buffer = smoother.smooth(buffer.to_a)
      pulses = pulse_detection.parse(smoothed_buffer)
      pulse_timestamps = PulseTimeSeries.new(pulses, sample_frequency).to_pulse_timestamps
      rithm_detector.pulse_timestamps = pulse_timestamps

      #puts %w(buffer smoothed pulses).join(';')
      #buffer.to_a.zip(smoothed_buffer, pulses).each do |b,s,p|
        #puts [b.round,s.round,p].join(';')
      #end
      #puts pulse_timestamps
      #puts rithm_detector.allowed_time_serie_ranges
      #puts rithm.to_pulse_timestamps
      #puts "rithm_detector scaling: #{rithm_detector.determine_scale}"

      expect(rithm_detector.valid?).to eq true
    end

    it "eventually plays SOS and matches valid on last beat" do
      play_function_proc = eventual_rithm.play_function_proc
      number_of_samples.times do
        buffer << sampler.sample(play_function_proc)
      end
      smoothed_buffer = smoother.smooth(buffer.to_a)
      pulses = pulse_detection.parse(smoothed_buffer)
      pulse_timestamps = PulseTimeSeries.new(pulses, sample_frequency).to_pulse_timestamps
      rithm_detector.pulse_timestamps = pulse_timestamps

      puts %w(buffer smoothed pulses).join(';')
      buffer.to_a.zip(smoothed_buffer, pulses).each do |b,s,p|
        puts [b.round,s.round,p].join(';')
      end
      puts pulse_timestamps
      puts rithm_detector.allowed_time_serie_ranges
      puts rithm.to_pulse_timestamps
      puts "rithm_detector scaling: #{rithm_detector.determine_scale}"

      expect(rithm_detector.valid?).to eq true
    end

    it "plays wrong rithm and never matches" do
      play_function_proc = wrong_rithm.play_function_proc
      number_of_samples.times do
        buffer << sampler.sample(play_function_proc)
      end
      smoothed_buffer = smoother.smooth(buffer.to_a)
      pulses = pulse_detection.parse(smoothed_buffer)
      pulse_timestamps = PulseTimeSeries.new(pulses, sample_frequency).to_pulse_timestamps
      rithm_detector.pulse_timestamps = pulse_timestamps

      expect(rithm_detector.valid?).to eq false
    end
  end

end
