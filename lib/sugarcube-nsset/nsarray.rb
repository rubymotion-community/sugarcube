class NSArray

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

end
