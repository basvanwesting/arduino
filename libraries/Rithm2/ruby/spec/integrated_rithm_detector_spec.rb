require 'spec_helper'

describe IntegratedRithmDetector, slow: true do

  describe "play and detect rithm" do
    let(:rithm_frequency)         { 11 }
    let(:expected_rithm_array)    { [1,1,1,1,0,1,0,1,0,1,1,1] }
    let(:sampler_frequency)       { rithm_frequency * 5 }
    let(:buffer_duration)         { 1.2 * 1.25 } #sec
    let(:smoother_function)       { NormalDistribution.new(mean: 0, stddev: 1) }
    let(:pulse_detection_low)     { 9  }
    let(:pulse_detection_high)    { 11 }

    let(:sampler_duration)        { rithm.duration * 1.25 } #sec
    let(:number_of_samples)       { (sampler_duration * sampler_frequency).to_i }

    let(:right_rithm)      { Rithm.new([      0,0,1,1,1,1,0,1,0,1,0,1,1,1,0,0,0],rithm_frequency) }
    let(:wrong_rithm)      { Rithm.new([      0,0,1,1,1,1,0,1,0,1,1,0,1,1,0,0,0],rithm_frequency) }
    let(:eventual_rithm)   { Rithm.new([1,0,0,0,0,1,1,1,1,0,1,0,1,0,1,1,1,0,0,0],rithm_frequency) }

    subject do
      described_class.new(
        rithm_frequency:      rithm_frequency,
        expected_rithm_array: expected_rithm_array,
        sampler_frequency:    sampler_frequency,
        buffer_duration:      buffer_duration,
        smoother_function:    smoother_function,
        pulse_detection_low:  pulse_detection_low,
        pulse_detection_high: pulse_detection_high,
      )
    end

    context "correct rithm" do
      let(:rithm) { right_rithm }

      it "plays SOS and matches valid on last beat" do
        rithm_detected = false
        play_function_proc = rithm.play_function_proc

        number_of_samples.times do
          subject.sample(play_function_proc)
          if subject.rithm_detected?
            rithm_detected = true
            break
          end
        end

        expect(rithm_detected).to eq true
      end
    end

    context "wrong rithm" do
      let(:rithm) { wrong_rithm }

      it "plays SOS and matches valid on last beat" do
        rithm_detected = false
        play_function_proc = rithm.play_function_proc

        number_of_samples.times do
          subject.sample(play_function_proc)
          if subject.rithm_detected?
            rithm_detected = true
            break
          end
        end

        expect(rithm_detected).to eq false
      end
    end

    context "eventual rithm" do
      let(:rithm) { eventual_rithm }

      it "plays SOS and matches valid on last beat" do
        rithm_detected = false
        play_function_proc = rithm.play_function_proc

        number_of_samples.times do
          subject.sample(play_function_proc)
          if subject.rithm_detected?
            rithm_detected = true
            break
          end
        end

        expect(rithm_detected).to eq true
      end
    end

  end

end
