class Sampler
  attr_accessor :frequency, :function
  attr_accessor :last_sample_timestamp

  def initialize(frequency: frequency)
    self.frequency = frequency
    self.last_sample_timestamp = current_time
  end

  def sample(function)
    if delay_to_next_sample > 0.0
      sleep(delay_to_next_sample)
    else
      puts "*** UNDERSAMPLING ***"
    end
    function.call(current_time).tap { self.last_sample_timestamp = current_time }
  end

  def delay_to_next_sample
    last_sample_timestamp + interval - current_time
  end

  def current_time
    Time.now.to_f
  end

  def interval
    1.0 / frequency
  end

end

