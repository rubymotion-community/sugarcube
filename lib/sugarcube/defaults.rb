class Symbol

  def get_default
    to_s.get_default
  end

  def get_default_or(default)
    to_s.get_default_or(default)
  end

  def set_default val
    to_s.set_default val
  end

  def remove_default
    to_s.remove_default
  end

end


class String

  def get_default(default=nil)
    NSUserDefaults.standardUserDefaults.objectForKey(self)
  end

  def get_default_or(default)
    raise "Invalid default value" if default.nil?

    nsdefault = self.get_default
    if nsdefault.nil?
      self.set_default(default)
      nsdefault = default
    end
    return nsdefault
  end

  def set_default val
    NSUserDefaults.standardUserDefaults.setObject(val, forKey:self)
  end

  def remove_default
    NSUserDefaults.standardUserDefaults.removeObjectForKey(self)
  end

end
