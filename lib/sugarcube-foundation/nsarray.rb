class NSArray

  # Creates an NSIndexPath object using the items in `self` as the indices
  # @return [NSIndexPath]
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

  # Creates an NSIndexSet object using the items in `self` as the indices
  # @return [NSIndexSet]
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

  def nsset
    NSSet.setWithArray self
  end
  
  def nsorderedset
    NSOrderedSet.orderedSetWithArray self
  end

end
