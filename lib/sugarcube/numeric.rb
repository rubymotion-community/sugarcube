class Numeric

  def percent
    self / 100.0
  end

  def seconds
    self
  end
  alias :second :seconds

  def minutes
    self * 60
  end
  alias :minute :minutes

  def hours
    self * 3600
  end
  alias :hour :hours

  def later(user_info=nil, &fire)
    NSTimer.scheduledTimerWithTimeInterval(self.to_f, target: fire, selector: 'call:', userInfo: user_info, repeats: false)
  end

end
