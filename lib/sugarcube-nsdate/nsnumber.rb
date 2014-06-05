class NSNumber

  def nsdate
    NSDate.dateWithTimeIntervalSince1970(self)
  end

  def before(date)
    date - self
  end

  def ago
    self.before(NSDate.new)
  end

  def after(date)
    date + self
  end

  def hence
    self.after(NSDate.new)
  end

end
