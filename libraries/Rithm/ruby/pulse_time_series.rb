require 'delegate'

class PulseTimeSeries < SimpleDelegator

  def fubar
    __getobj__.inspect
  end

  def to_input_time_series(frequency: 1, stddev: 0)
    InputTimeSeriesBuilder.new(self, frequency: frequency, stddev: stddev).call
  end

  class InputTimeSeriesBuilder
    attr_accessor :pulse_time_series, :frequency, :stddev

    def initialize(pulse_time_series, frequency: frequency, stddev: stddev)
      self.pulse_time_series = pulse_time_series
      self.frequency         = frequency
      self.stddev            = stddev
    end

    def call
      Sampler.new(
        start_timestamp: pulse_time_series.first,
        end_timestamp:   pulse_time_series.last,
        frequency: frequency,
      ).call(*pulse_functions)
    end

    def single_pulse_function(pulse_timestamp)
      NormalDistribution.new(mean: pulse_timestamp, stddev: stddev)
    end

    def pulse_functions
      pulse_time_series.map do |pulse_timestamp|
        single_pulse_function(pulse_timestamp)
      end
    end

  end

end
