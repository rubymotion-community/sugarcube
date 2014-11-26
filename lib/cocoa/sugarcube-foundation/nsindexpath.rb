class NSIndexPath

  # support multiple assignment
  #
  # example:
  #     a, b = NSIndexPath.indexPathWithIndex(1).indexPathByAddingIndex(3)
  #     a  # => 1
  #     b  # => 3
  def to_ary
    to_a
  end

  # convert to an array of integers
  #
  # example:
  #     path = NSIndexPath.indexPathWithIndex(1).indexPathByAddingIndex(3)
  #     path.to_a  # => [1, 3]
  def to_a
    self.length.times.reduce([]) do |a, i|
      a << self.indexAtPosition(i)
    end
  end

end
