class Rithm
  attr_accessor :beats, :frequency

  def initialize(beats, frequency=1)
    self.beats = beats
    self.frequency = frequency
  end

  def interval
    1.0 / frequency
  end

  def to_pulse_time_series
    PulseTimeSeries.new(
      [
        beats,
        beats.size.times.map { |t| t * interval },
      ].transpose.map do |beat, timestamp|
        timestamp if beat == 1
      end.compact
    )
  end

  def play
    pulse_time_series = to_pulse_time_series
    while pulse_time_series.size > 0
      current_time = pulse_time_series.shift
      next_time = pulse_time_series.first || current_time
      yield
      sleep next_time - current_time
    end
  end

end

