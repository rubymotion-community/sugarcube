class NSUserDefaults

  class << self
    # Retrieves the object for the passed key
    def [](key)
      self.standardUserDefaults.objectForKey(key.to_s)
    end

    # Sets the value for a given key and save it right away.
    def []=(key, val)
      if val == nil
        self.standardUserDefaults.removeObjectForKey(key)
      else
        self.standardUserDefaults.setObject(val.to_nsuserdefaults, forKey: key.to_s)
      end
      self.standardUserDefaults.synchronize
    end

    def remove(key)
      self.standardUserDefaults.removeObjectForKey(key)
      self.standardUserDefaults.synchronize
    end
  end

end


class Object
  def to_nsuserdefaults
    self
  end
end


class NilClass
  def to_nsuserdefaults
    false
  end
end


class NSArray
  def to_nsuserdefaults
    self.map { |val| val.to_nsuserdefaults }
  end
end


class NSDictionary
  def to_nsuserdefaults
    self.each_with_object({}) { |(key, val), h| h[key] = val.to_nsuserdefaults }
  end
end
