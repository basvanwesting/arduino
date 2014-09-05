class Sampler
  attr_accessor :start_timestamp, :end_timestamp, :frequency, :function
  attr_accessor :next_sample_timestamp, :input_time_series

  def initialize(start_timestamp: start_timestamp, end_timestamp: end_timestamp, frequency: frequency)
    self.start_timestamp       = start_timestamp
    self.end_timestamp         = end_timestamp
    self.frequency             = frequency
    self.next_sample_timestamp = current_time
    self.input_time_series     = []
  end

  def sample(function)
    if delay_to_next_sample > 0.0
      sleep(delay_to_next_sample)
    end
    self.next_sample_timestamp += interval
    input_time_series << [current_time, function.call(current_time)]
  end

  def delay_to_next_sample
    next_sample_timestamp - current_time
  end

  def current_time
    Time.now
  end

  def interval
    1.0 / frequency
  end

  ###

  def call(*functions)
    self.input_time_series =
      timestamps.map do |timestamp|
        [
          timestamp,
          functions.inject(0.0) { |sum, f| sum + f.call(timestamp) }
        ]
      end
  end

  def timestamps
    start_timestamp.step(end_timestamp, interval)
  end

end
