class PulseTimestampBuffer
  attr_accessor :duration, :array

  def initialize(duration)
    self.duration = duration
    self.array = []
  end

  def pulse!
    self << Time.now.to_f
  end

  def <<(entry)
    min_timestamp = entry - duration
    array.reject! { |e| e < min_timestamp }
    array << entry
  end

  def to_a
    array
  end

  def to_relative_a
    offset_time = array.first
    array.map { |time| time - offset_time }
  end

end
