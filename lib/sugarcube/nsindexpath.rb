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

  def to_s
    "<NSIndexPath #{to_a.to_s}>"
  end

end


# This class is used in `switch` statements.  Easy pattern matching, so instead
# of `if index_path.row...index_path.section`, you can use
# `when IndexPath[row, section]`
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