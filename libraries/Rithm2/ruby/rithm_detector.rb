require_relative 'rithm'
class RithmDetector
  attr_accessor :rithm, :margin
  attr_accessor :expected_pulse_timestamps, :pulse_timestamps

  def initialize(rithm, margin: nil, pulse_timestamps: [])
    self.rithm = rithm
    self.margin = margin || rithm.interval * 0.25
    self.pulse_timestamps = pulse_timestamps
    self.expected_pulse_timestamps = rithm.to_pulse_timestamps
  end

  def allowed_time_serie_ranges
    expected_pulse_timestamps.map do |time|
      (time - margin)..(time + margin)
    end
  end

  def offset_pulse_timestamps
    offset_time = pulse_timestamps.first
    pulse_timestamps.map { |time| time - offset_time }
  end

  def invalid_pulse_timestamps?
    allowed_time_serie_ranges.zip(offset_pulse_timestamps).detect do |range, time|
      !range.include?(time)
    end
  end

  def valid_pulse_timestamps?
    !invalid_pulse_timestamps?
  end
  alias_method :valid?, :valid_pulse_timestamps?

end
