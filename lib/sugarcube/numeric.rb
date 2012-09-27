class Numeric

  def percent
    self / 100.0
  end

  def degrees
    self / 180.0 * Math::PI
  end

  def pi
    self * Math::PI
  end

end
