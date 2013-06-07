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

end
