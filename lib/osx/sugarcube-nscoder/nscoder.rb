class NSCoder

  def point(key)
    self.decodeObjectForKey(key.to_s).pointValue
  end

  def rect(key)
    self.decodeObjectForKey(key.to_s).rectValue
  end

  def size(key)
    self.decodeObjectForKey(key.to_s).sizeValue
  end

  def set(key, toPoint: value)
    self.encodeObject(NSValue.valueWithPoint(value), forKey: key.to_s)
    self
  end

  def set(key, toRect: value)
    self.encodeObject(NSValue.valueWithRect(value), forKey: key.to_s)
    self
  end

  def set(key, toSize: value)
    self.encodeObject(NSValue.valueWithSize(value), forKey: key.to_s)
    self
  end

end
