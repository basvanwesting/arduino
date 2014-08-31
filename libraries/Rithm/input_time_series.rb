require 'delegate'

class InputTimeSeries < SimpleDelegator
  attr_accessor :max_length

  def <<(entry)
    if size >= max_length
      shift
    end
    super
  end

end
