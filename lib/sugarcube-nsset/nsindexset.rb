class NSIndexSet
  def to_a
    a = []
    self.enumerateIndexesUsingBlock(
      lambda do |idx, stop_ptr|
        a << idx
      end
    )
    a
  end
end
