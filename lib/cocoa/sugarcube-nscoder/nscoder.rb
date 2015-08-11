# Hash-like access for NSCoder.  Converts the `key` argument to a String,
# because Symbols can mess things up.
class NSCoder

  def [] key
    self.decodeObjectForKey(key.to_s)
  end

  def []= key, value
    self.encodeObject(value, forKey: key.to_s)
  end

  def key?(key)
    self.containsValueForKey(key.to_s)
  end

  def bool(key)
    self.decodeBoolForKey(key.to_s)
  end

  def double(key)
    self.decodeDoubleForKey(key.to_s)
  end

  def float(key)
    self.decodeFloatForKey(key.to_s)
  end

  def int(key)
    self.decodeIntegerForKey(key.to_s)
  end

  def set(key, toBool: value)
    self.encodeBool(value, forKey: key.to_s)
    self
  end

  def set(key, toDouble: value)
    self.encodeDouble(value, forKey: key.to_s)
    self
  end

  def set(key, toFloat: value)
    self.encodeFloat(value, forKey: key.to_s)
    self
  end

  def set(key, toInt: value)
    self.encodeInteger(value, forKey: key.to_s)
    self
  end

end


class NSCoder

  def self.archive(root)
    NSKeyedArchiver.archivedDataWithRootObject(root)
  end

  def self.archive(root, to_file: file)
    NSKeyedArchiver.archivedRootObject(root, toFile: file)
  end

  def self.unarchive(data_or_file)
    if data_or_file.is_a?(NSData)
      NSKeyedUnarchiver.unarchiveObjectWithData(data_or_file)
    else
      NSKeyedUnarchiver.unarchiveObjectWithFile(data_or_file)
    end
  end

end
