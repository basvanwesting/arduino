require_relative 'rithm'
class RithmDetector
  attr_accessor :rithm, :margin
  attr_accessor :expected_pulse_time_series, :pulse_time_series

  def initialize(rithm, margin: nil, pulse_time_series: [])
    self.rithm = rithm
    self.margin = margin || rithm.interval * 0.25
    self.pulse_time_series = pulse_time_series

    self.expected_pulse_time_series = rithm.to_pulse_time_series
  end

  def set_pulse_time_series=(new_pulse_time_series)
    self.pulse_time_series = new_pulse_time_series
    truncate_pulse_time_series!
  end

  def truncate_pulse_time_series!
    while pulse_time_series.size > expected_pulse_time_series.size
      pulse_time_series.shift
    end
  end

  def detect_beat!
    self.pulse_time_series << Time.now
    truncate_pulse_time_series!
  end

  def allowed_time_serie_ranges
    expected_pulse_time_series.map do |time|
      (time - margin)..(time + margin)
    end
  end

  def offset_pulse_time_series
    offset_time = pulse_time_series.first
    pulse_time_series.map { |time| time - offset_time }
  end

  def invalid_pulse_time_series?
    allowed_time_serie_ranges.zip(offset_pulse_time_series).detect do |range, time|
      !range.include?(time)
    end
  end

  def valid_pulse_time_series?
    !invalid_pulse_time_series?
  end
  alias_method :valid?, :valid_pulse_time_series?

end
