class Symbol

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
