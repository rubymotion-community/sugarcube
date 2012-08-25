class Array

  def to_pointer(type)
    ret = Pointer.new(type, self.length)
    self.each_index do |i|
      ret[i] = self[i]
    end
    ret
  end

  def uiindexpath
    if self.length == 0
      raise "An index path must have at least one index"
    end

    path = nil
    self.each do |val|
      if path
        path = path.indexPathByAddingIndex(val)
      else
        path = NSIndexPath.indexPathWithIndex(val)
      end
    end
    return path
  end

end
