class Buffer
  attr_accessor :max_size, :array

  def initialize(max_size)
    self.max_size = max_size
    self.array = Array.new(max_size,0)
  end

  def <<(entry)
    if array.size >= max_size
      array.shift
    end
    array << entry
  end

  def to_a
    array
  end

end

