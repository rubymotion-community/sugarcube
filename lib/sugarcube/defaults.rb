class Symbol

  def get_default
    to_s.get_default
  end

  def set_default val
    to_s.set_default val
  end

  def remove_default
    to_s.remove_default
  end

end


class String

  def get_default
    NSUserDefaults.standardUserDefaults.objectForKey(self)
  end

  def set_default val
    NSUserDefaults.standardUserDefaults.setObject(val, forKey:self)
  end

  def remove_default
    NSUserDefaults.standardUserDefaults.removeObjectForKey(self)
  end

end
