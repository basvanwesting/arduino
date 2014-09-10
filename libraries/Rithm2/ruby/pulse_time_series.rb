class PulseTimeSeries
  attr_accessor :pulses, :frequency

  def initialize(pulses, frequency)
    self.pulses = pulses
    self.frequency = frequency
  end

  def interval
    1.0 / frequency
  end

  def to_relative_pulse_timestamps
    [
      pulses,
      pulses.size.times.map { |t| t * interval },
    ].transpose.map do |pulse, timestamp|
      timestamp if pulse == 1
    end.compact
  end

  def to_absolute_pulse_timestamps
    self.class.relative_to_absolute_timestamps(to_relative_pulse_timestamps)
  end

  def self.absolute_to_relative_pulse_timestamps(pulse_timestamps)
    offset_time = pulse_timestamps.first
    pulse_timestamps.map { |time| time - offset_time }
  end

  def self.relative_to_absolute_timestamps(pulse_timestamps)
    offset_time = pulse_timestamps.last
    current_time = Time.now.to_f
    pulse_timestamps.map { |time| current_time - offset_time + time }
  end

end
