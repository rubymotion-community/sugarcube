class NSCoder

  def point(key)
    CGPointFromString(self.decodeObjectForKey(key.to_s))
  end

  def rect(key)
    CGRectFromString(self.decodeObjectForKey(key.to_s))
  end

  def size(key)
    CGSizeFromString(self.decodeObjectForKey(key.to_s))
  end

  def set(key, toPoint: value)
    self.encodeObject(NSStringFromCGPoint(value), forKey: key.to_s)
    self
  end

  def set(key, toRect: value)
    self.encodeObject(NSStringFromCGRect(value), forKey: key.to_s)
    self
  end

  def set(key, toSize: value)
    self.encodeObject(NSStringFromCGSize(value), forKey: key.to_s)
    self
  end

end
