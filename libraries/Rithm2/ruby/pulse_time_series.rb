class PulseTimeSeries
  attr_accessor :pulses, :frequency

  def initialize(pulses, frequency)
    self.pulses = pulses
    self.frequency = frequency
  end

  def interval
    1.0 / frequency
  end

  def to_pulse_timestamps
    [
      pulses,
      pulses.size.times.map { |t| t * interval },
    ].transpose.map do |pulse, timestamp|
      timestamp if pulse == 1
    end.compact
  end
end
