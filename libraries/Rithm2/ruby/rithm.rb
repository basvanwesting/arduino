class Rithm
  attr_accessor :pulses, :frequency, :proc_created_at

  def initialize(pulses, frequency=1)
    self.pulses = pulses
    self.frequency = frequency
  end

  def interval
    1.0 / frequency
  end

  def current_time
    Time.now.to_f
  end

  def to_pulse_timestamps
    PulseTimeSeries.new(pulses, frequency).to_pulse_timestamps
  end

  def play
    pulses.size.times do |index|
      next_time = current_time + interval
      yield if pulses[index] == 1
      sleep next_time - current_time
    end
  end

  def play_function_proc
    self.proc_created_at = current_time
    method(:play_function)
  end

  def play_function(time)
    pulse_functions.inject(0.0) do |sum, function|
      sum += function.call(time - proc_created_at)
    end
  end

  def single_pulse_function(pulse_timestamp)
    NormalDistribution.new(mean: pulse_timestamp, stddev: interval / 10)
  end

  def pulse_functions
    to_pulse_timestamps.map do |pulse_timestamp|
      single_pulse_function(pulse_timestamp)
    end
  end

end

