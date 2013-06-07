class Numeric

  def radians
    self
  end
  alias radian radians

  def in_radians
    self
  end

  def degrees
    self / 180.0 * Math::PI
  end
  alias degree degrees

  def in_degrees
    self * 180.0 / Math::PI
  end

  def pi
    self * Math::PI
  end

end
