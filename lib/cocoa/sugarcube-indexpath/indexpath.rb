# This class is used in `switch` statements.  Easy pattern matching, so instead
# of `if index_path.section == N && index_path.row = X`, you can use
# `when IndexPath[section, row]`.
#
# Example:
#
#     case index_path
#     when IndexPath[0, 0]  # first section, first row
#     when IndexPath[1]     # second section, any row
#     when IndexPath[2, 0..N]  # third section, 0..Nth rows
#     when IndexPath[2]     # all other in third section
#     end
#
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