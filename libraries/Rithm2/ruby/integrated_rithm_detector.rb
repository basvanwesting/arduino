class IntegratedRithmDetector
  attr_accessor \
    :rithm_frequency,
    :expected_rithm_array,
    :sampler_frequency,
    :buffer_duration,
    :smoother_function,
    :pulse_detection_low,
    :pulse_detection_high

  attr_accessor \
    :expected_rithm,
    :rithm_detector,
    :sampler,
    :buffer,
    :smoother,
    :pulse_detection,
    :pulse_timestamp_buffer

  def initialize(options = {})
    self.rithm_frequency      = options[:rithm_frequency]
    self.expected_rithm_array = options[:expected_rithm_array]
    self.sampler_frequency    = options[:sampler_frequency]
    self.buffer_duration      = options[:buffer_duration]
    self.smoother_function    = options[:smoother_function]
    self.pulse_detection_low  = options[:pulse_detection_low]
    self.pulse_detection_high = options[:pulse_detection_high]

    setup
  end

  def setup
    self.expected_rithm = Rithm.new(expected_rithm_array,rithm_frequency)
    self.rithm_detector = RithmDetector.new(expected_rithm)

    self.sampler = Sampler.new(frequency: sampler_frequency)
    self.buffer = Buffer.new(size_of_buffer)
    self.smoother = FunctionSmoother.new(smoother_function)
    self.pulse_detection = PulseDetection.new(low: pulse_detection_low, high: pulse_detection_high)
    self.pulse_timestamp_buffer = PulseTimestampBuffer.new(buffer_duration)
  end

  def size_of_buffer
    (buffer_duration / sampler.interval).to_i
  end

  def sample(function_proc)
    buffer << sampler.sample(function_proc)
    smoothed_buffer = smoother.smooth(buffer.to_a)
    pulse_timestamp_buffer.pulse! if pulse_detection.detect_from_input(smoothed_buffer)
    rithm_detector.pulse_timestamps = pulse_timestamp_buffer.to_a
  end

  def rithm_detected?
    rithm_detector.valid?
  end

end
