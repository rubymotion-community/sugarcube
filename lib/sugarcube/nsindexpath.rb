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
