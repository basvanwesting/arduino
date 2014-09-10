class PulseTimestampBuffer
  attr_accessor :duration, :array

  def initialize(duration)
    self.duration = duration
    self.array = []
  end

  def <<(entry)
    min_timestamp = entry - duration
    array.reject! { |e| e < min_timestamp }
    array << entry
  end

  def to_a
    array
  end

end
