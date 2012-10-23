class NSIndexPath
  def to_a
    indexes_ptr = Pointer.new(:uint, self.length)
    self.getIndexes indexes_ptr
    a = []
    self.length.times do |i|
      a << indexes_ptr[i]
    end
    a
  end
end


class IndexPath

  def self.[] *values
    IndexPath.new values
  end

  def initialize values
    @values = values
  end

  def === other
    return true if super

    if other.is_a? NSIndexPath
      other = other.to_a
    end

    if other.is_a? Enumerable
      ret = true
      other_i = 0
      @values.each do |val|
        next_val = other[other_i]
        other_i += 1
        unless val == true || val === next_val
          ret = false
          break
        end
      end

      return ret
    end
    return false
  end

end