class PulseDetection
  attr_accessor :low, :high, :state

  def initialize(low: low, high: high)
    self.low = low
    self.high = high
    self.state = :low
  end

  def parse(input)
    input.map do |value|
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

end
