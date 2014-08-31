class NormalDistribution
  attr_accessor :mean, :stddev

  def initialize(mean: 0, stddev: 1)
    self.mean   = mean
    self.stddev = stddev
  end

  def call(x)
    if stddev > 0.0
      Math.exp( -1.0 * (x - mean)**2 / (2*stddev*stddev) ) / constant
    else
      x == mean ? 1.0 : 0.0
    end
  end

  def constant
    stddev * Math.sqrt(2 * Math::PI)
  end
end
