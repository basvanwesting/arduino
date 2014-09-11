require 'spec_helper'

describe 'Integration of all elements using moving window', slow: true, debug: true do

  describe "play and detect rithm" do
    let(:rithm_frequency)         { 11 }
    let(:sampler_frequency)       { rithm_frequency * 5 }
    let(:sampler_duration)        { rithm.duration * (1 + rithm_detector.scaling_margin) } #sec
    let(:number_of_samples)       { (sampler_duration / sampler.interval).to_i }
    let(:buffer_duration)         { expected_rithm.duration * (1 + rithm_detector.scaling_margin) } #sec
    let(:size_of_buffer)          { (buffer_duration / sampler.interval).to_i }

    let(:smoother_function)       { NormalDistribution.new(mean: 0, stddev: 1) }
    let(:pulse_detection_low)     { 9  }
    let(:pulse_detection_high)    { 11 }

    let(:expected_rithm)   { Rithm.new([          1,1,1,1,0,1,0,1,0,1,1,1],rithm_frequency) }
    let(:right_rithm)      { Rithm.new([      0,0,1,1,1,1,0,1,0,1,0,1,1,1,0,0,0],rithm_frequency) }
    let(:wrong_rithm)      { Rithm.new([      0,0,1,1,1,1,0,1,0,1,1,0,1,1,0,0,0],rithm_frequency) }
    let(:eventual_rithm)   { Rithm.new([1,0,0,0,0,1,1,1,1,0,1,0,1,0,1,1,1,0,0,0],rithm_frequency) }

    let(:sampler)                { Sampler.new(frequency: sampler_frequency) }
    let(:buffer)                 { Buffer.new(size_of_buffer) }
    let(:smoother)               { FunctionSmoother.new(smoother_function) }
    let(:pulse_detection)        { PulseDetection.new(low: pulse_detection_low, high: pulse_detection_high) }
    let(:pulse_timestamp_buffer) { PulseTimestampBuffer.new(buffer_duration) }
    let(:rithm_detector)         { RithmDetector.new(expected_rithm) }

    before do
      puts "rithm frequency: #{rithm_frequency}"
      puts "rithm interval: #{rithm.interval}"
      puts "sampler frequency: #{sampler_frequency}"
      puts "sampler interval: #{sampler.interval}"
      puts "expected_rithm duration: #{expected_rithm.duration}"
      puts "rithm duration: #{rithm.duration}"
      puts "number of samples: #{number_of_samples}"
      puts "sampler duration: #{sampler_duration}"
      puts "size of buffer: #{size_of_buffer}"
      puts "buffer duration: #{buffer_duration}"
      puts "rithm_detector timing_margin: #{rithm_detector.timing_margin}"
      puts "rithm_detector scaling_margin: #{rithm_detector.scaling_margin}"
    end

        #puts %w(buffer smoothed pulses).join(';')
        #smoothed_buffer = smoother.smooth(total_buffer)
        #pulses = pulse_detection.parse(smoothed_buffer)
        #rithm_detector.pulse_timestamps = pulse_timestamps

        #total_buffer.to_a.zip(smoothed_buffer, pulses).each do |b,s,p|
          #puts [b.round,s.round,p].join(';')
        #end
        #puts pulse_timestamps
        #puts rithm_detector.allowed_time_serie_ranges
        #puts "rithm_detector scaling: #{rithm_detector.determine_scale}"
        #puts "detected using total: #{rithm_detector.valid?}"

    context "correct rithm" do
      let(:rithm) { right_rithm }

      it "plays SOS and matches valid on last beat" do
        rithm_detected = false
        play_function_proc = rithm.play_function_proc

        total_buffer = []

        number_of_samples.times do
          sample_value = sampler.sample(play_function_proc)
          buffer << sample_value
          total_buffer << sample_value
          smoothed_buffer = smoother.smooth(buffer.to_a)
          if pulse_detection.detect_from_input(smoothed_buffer)
            pulse_timestamp_buffer.pulse!
            puts pulse_timestamp_buffer.to_relative_a.inspect
          end
          rithm_detector.pulse_timestamps = pulse_timestamp_buffer.to_a
          rithm_detected = true if rithm_detector.valid?
        end

        expect(rithm_detected).to eq true
      end
    end

    context "wrong rithm" do
      let(:rithm) { wrong_rithm }

      it "plays SOS and matches valid on last beat" do
        rithm_detected = false
        play_function_proc = rithm.play_function_proc

        total_buffer = []

        number_of_samples.times do
          sample_value = sampler.sample(play_function_proc)
          buffer << sample_value
          total_buffer << sample_value
          smoothed_buffer = smoother.smooth(buffer.to_a)
          if pulse_detection.detect_from_input(smoothed_buffer)
            pulse_timestamp_buffer.pulse!
            puts pulse_timestamp_buffer.to_relative_a.inspect
          end
          rithm_detector.pulse_timestamps = pulse_timestamp_buffer.to_a
          rithm_detected = true if rithm_detector.valid?
        end

        expect(rithm_detected).to eq false
      end
    end

    context "eventual rithm" do
      let(:rithm) { eventual_rithm }

      it "plays SOS and matches valid on last beat" do
        rithm_detected = false
        play_function_proc = rithm.play_function_proc

        total_buffer = []

        number_of_samples.times do
          sample_value = sampler.sample(play_function_proc)
          buffer << sample_value
          total_buffer << sample_value
          smoothed_buffer = smoother.smooth(buffer.to_a)
          if pulse_detection.detect_from_input(smoothed_buffer)
            pulse_timestamp_buffer.pulse!
            puts pulse_timestamp_buffer.to_relative_a.inspect
          end
          rithm_detector.pulse_timestamps = pulse_timestamp_buffer.to_a
          rithm_detected = true if rithm_detector.valid?
        end

        expect(rithm_detected).to eq true
      end
    end

  end

end
