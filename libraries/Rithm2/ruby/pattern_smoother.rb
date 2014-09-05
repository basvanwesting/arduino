class PatternSmoother
  attr_accessor :pattern

  def initialize(pattern)
    self.pattern = pattern
  end

  def pattern_index_offsets
    middle = (pattern.size - 1) / 2
    pattern.size.times.map do |index|
      index - middle
    end
  end

  def smooth(input)
    input.size.times.map do |index|
      sum = 0.0
      pattern_index_offsets.each_with_index do |pattern_index_offset, pattern_index|
        input_index = index + pattern_index_offset
        next if input_index < 0
        next if input_index > input.size - 1
        sum += input[input_index].to_f * pattern[pattern_index].to_f
      end
      sum
    end
  end
end
