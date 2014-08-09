class Rithm
  attr_accessor :beats, :delay

  def initialize(beats, delay=0.2)
    self.beats = beats
    self.delay = delay
  end

  def to_time_series
    [
      beats,
      beats.size.times.map { |t| t * delay },
    ].transpose.map do |beat, timestamp|
      timestamp if beat == 1
    end.compact
  end

  def play
    time_series = to_time_series
    while time_series.size > 0
      current_time = time_series.shift
      next_time = time_series.first || current_time
      yield
      sleep next_time - current_time
    end
  end

end

