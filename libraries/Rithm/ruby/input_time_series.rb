require 'delegate'

class InputTimeSeries < SimpleDelegator
  attr_accessor :max_length

  def <<(entry)
    if max_length && size >= max_length
      shift
    end
    super
  end

end
