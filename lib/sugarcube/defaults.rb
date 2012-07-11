
class Symbol

  def get_default
    NSUserDefaults.standardUserDefaults.objectForKey(self)
  end

  def remove_default
    NSUserDefaults.standardUserDefaults.removeObjectForKey(self)
  end

end


class Object

  def save_to_default(key)
    NSUserDefaults.standardUserDefaults.setObject(self, forKey:key)
  end

end
