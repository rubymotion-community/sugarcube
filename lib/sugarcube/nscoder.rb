class NSCoder

  def [] key
    return self.decodeObjectForKey key
  end

  def []= key, value
    return self.encodeObject(value, forKey:key)
  end

  def bool(key)
    return self.decodeBoolForKey(key)
  end

  def double(key)
    return self.decodeDoubleForKey(key)
  end

  def float(key)
    return self.decodeFloatForKey(key)
  end

  def int(key)
    return self.decodeIntegerForKey(key)
  end

  def point(key)
    return CGPointFromString(self.decodeObjectForKey(key))
  end

  def rect(key)
    return CGRectFromString(self.decodeObjectForKey(key))
  end

  def size(key)
    return CGSizeFromString(self.decodeObjectForKey(key))
  end

  def set(key, toBool:value)
    self.encodeBool(value, forKey:key)
    return self
  end

  def set(key, toDouble:value)
    self.encodeDouble(value, forKey:key)
    return self
  end

  def set(key, toFloat:value)
    self.encodeFloat(value, forKey:key)
    return self
  end

  def set(key, toInt:value)
    self.encodeInteger(value, forKey:key)
    return self
  end

  def set(key, toPoint:value)
    self.encodeObject(NSStringFromCGPoint(value), forKey:key)
    return self
  end

  def set(key, toRect:value)
    self.encodeObject(NSStringFromCGRect(value), forKey:key)
    return self
  end

  def set(key, toSize:value)
    self.encodeObject(NSStringFromCGSize(value), forKey:key)
    return self
  end

end
