require_relative 'rithm'
class RithmDetector
  attr_accessor :rithm, :timing_margin, :scaling_margin
  attr_accessor :expected_pulse_timestamps, :pulse_timestamps

  def initialize(rithm, timing_margin: nil, scaling_margin: nil, pulse_timestamps: [])
    self.rithm = rithm
    self.timing_margin = timing_margin || rithm.interval * 0.25
    self.scaling_margin = scaling_margin || 0.25
    self.pulse_timestamps = pulse_timestamps
    self.expected_pulse_timestamps = rithm.to_pulse_timestamps
  end

  def allowed_time_serie_ranges
    scale = determine_scale
    expected_pulse_timestamps.map do |time|
      scaled_time = time * scale
      (scaled_time - timing_margin)..(scaled_time + timing_margin)
    end
  end

  def determine_scale
    actual_runtime = offset_corrected_pulse_timestamps.last
    expected_runtime = expected_pulse_timestamps.last
    scaling_factor = actual_runtime.to_f / expected_runtime

    if scaling_factor > (1.0 - scaling_margin) and scaling_factor < (1.0 + scaling_margin)
      scaling_factor
    else
      1.0
    end
  end

  def offset_corrected_pulse_timestamps
    offset_time = pulse_timestamps.first
    pulse_timestamps.map { |time| time - offset_time }
  end

  def invalid_pulse_timestamps?
    allowed_time_serie_ranges.zip(offset_corrected_pulse_timestamps).detect do |range, time|
      !range.include?(time)
    end
  end

  def valid_pulse_timestamps?
    !invalid_pulse_timestamps?
  end
  alias_method :valid?, :valid_pulse_timestamps?

end
