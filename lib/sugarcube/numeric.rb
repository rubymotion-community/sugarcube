class Numeric

  def percent
    self / 100.0
  end

  def radians
    self
  end
  alias radian radians

  def degrees
    self / 180.0 * Math::PI
  end
  alias degree degrees

  def pi
    self * Math::PI
  end

  def meters
    self
  end
  alias meter meters

  def in_meters
    self
  end

  def kilometers
    self * 1000.0
  end
  alias kilometer kilometers

  def in_kilometers
    self / 1.kilometer
  end

  def miles
    self * 1609.344
  end
  alias mile miles

  def in_miles
    self / 1.mile
  end

  def feet
    self / 3.28084
  end
  alias foot feet

  def in_feet
    self / 1.foot
  end

  def string_with_style(style=NSNumberFormatterDecimalStyle)
    if style.is_a? Symbol
      style = style.nsnumberstyle
    end
    NSNumberFormatter.localizedStringFromNumber(self, numberStyle:style)
  end

end
