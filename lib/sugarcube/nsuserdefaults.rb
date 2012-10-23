class NSUserDefaults

  class << self
    # Retrieves the object for the passed key
    def [](key)
      self.standardUserDefaults.objectForKey(key.to_s)
    end

    # Sets the value for a given key and save it right away.
    def []=(key, val)
      self.standardUserDefaults.setObject(val, forKey: key.to_s)
      self.standardUserDefaults.synchronize
    end
  end

end
