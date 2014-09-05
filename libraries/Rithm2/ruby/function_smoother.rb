class FunctionSmoother
  attr_accessor :function

  def initialize(function)
    self.function = function
  end

  def smooth(input)
    result = Array.new(input.size, 0)
    input.size.times.map do |index|
      sum = 0.0
      input.size.times.each do |index_offset|
        function_index = index_offset - index
        sum += function.call(function_index).to_f * input[index_offset].to_f
      end
      result[index] = sum
    end
    result
  end
end
