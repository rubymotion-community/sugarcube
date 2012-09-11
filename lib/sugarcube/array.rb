class Array

  def to_pointer(type)
    ret = Pointer.new(type, self.length)
    self.each_index do |i|
      ret[i] = self[i]
    end
    ret
  end

  def nsindexpath
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

  def nsindexset
    if self.length == 0
      raise "An index set must have at least one index"
    end

    set = NSMutableIndexSet.indexSet
    self.each do |val|
      set.addIndex val
    end
    set
  end

  # [160, 210, 242].uicolor => 0xA0D2F2.uicolor
  def uicolor(alpha=1.0)
    red = self[0] / 255.0
    green = self[1] / 255.0
    blue = self[2] / 255.0
    UIColor.colorWithRed(red, green:green, blue:blue, alpha:alpha.to_f)
  end

end
