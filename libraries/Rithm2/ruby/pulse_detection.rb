class PulseDetection
  attr_accessor :low, :high, :state, :parsed_input

  def initialize(low: low, high: high)
    self.low = low
    self.high = high
    self.state = :low
    self.parsed_input = []
  end

  def parse(input)
    self.parsed_input = input.map do |value|
      if state == :low
        if value >= high
          self.state = :high
          1
        else
          0
        end
      else
        self.state = :low if value < low
        0
      end
    end
  end

  def detection_index
    parsed_input.size / 2
  end

  def pulse_detected?
    parsed_input[detection_index] == 1
  end

  def detect_from_input(input)
    parse(input)
    pulse_detected?
  end

end
