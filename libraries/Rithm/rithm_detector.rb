require_relative 'rithm'
class RithmDetector
  attr_accessor :rithm, :margin
  attr_accessor :expected_time_series, :time_series

  def initialize(rithm, margin: nil, time_series: [])
    self.rithm = rithm
    self.margin = margin || rithm.delay * 0.25
    self.time_series = time_series

    self.expected_time_series = rithm.to_time_series
  end

  def set_time_series=(new_time_series)
    self.time_series = new_time_series
    truncate_time_series!
  end

  def truncate_time_series!
    while time_series.size > expected_time_series.size
      time_series.shift
    end
  end

  def detect_beat!
    self.time_series << Time.now
    truncate_time_series!
  end

  def allowed_time_serie_ranges
    expected_time_series.map do |time|
      (time - margin)..(time + margin)
    end
  end

  def offset_time_series
    offset_time = time_series.first
    time_series.map { |time| time - offset_time }
  end

  def invalid_time_series?
    allowed_time_serie_ranges.zip(offset_time_series).detect do |range, time|
      !range.include?(time)
    end
  end

  def valid_time_series?
    !invalid_time_series?
  end
  alias_method :valid?, :valid_time_series?

end
