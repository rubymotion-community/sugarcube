class Numeric

  def percent
    self / 100.0
  end

  def radians
    self
  end

  def degrees
    self / 180.0 * Math::PI
  end

  def pi
    self * Math::PI
  end

  def meters
    self
  end

  def kilometers
    self / 1000.0
  end

  def miles
    self * 0.000621371
  end

  def feet
    self * 3.28084
  end

end
