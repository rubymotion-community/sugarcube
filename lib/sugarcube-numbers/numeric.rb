class Numeric

  def percent
    self / 100.0
  end

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

  def meters
    self
  end
  alias meter meters

  def in_meters
    self
  end

  def kilometers
    self * 1000.0  # 1000 m / km
  end
  alias kilometer kilometers

  def in_kilometers
    self / 1.kilometer
  end

  def miles
    self * 1609.344  # 1609.344 m / mi
  end
  alias mile miles

  def in_miles
    self / 1.mile
  end

  def feet
    self / 3.28084  # 3.28084 m / ft
  end
  alias foot feet

  def in_feet
    self / 1.foot
  end

  def bytes
    self
  end
  alias byte bytes

  def kilobytes
    self * 1024**1
  end
  alias kilobyte kilobytes

  def megabytes
    self * 1024**2
  end
  alias megabyte megabytes

  def gigabytes
    self * 1024**3
  end
  alias gigabyte gigabytes

  def terabytes
    self * 1024**4
  end
  alias terabyte terabytes

  def petabytes
    self * 1024**5
  end
  alias petabyte petabytes

  def exabytes
    self * 1024**6
  end
  alias exabyte exabytes

  def in_bytes
    self
  end

  def in_kilobytes
    self / 1024**1
  end

  def in_megabytes
    self / 1024**2
  end

  def in_gigabytes
    self / 1024**3
  end

  def in_terabytes
    self / 1024**4
  end

  def in_petabytes
    self / 1024**5
  end

  def in_exabytes
    self / 1024**6
  end

  def string_with_style(style=NSNumberFormatterDecimalStyle)
    if style.respond_to?(:nsnumberstyle)
      style = style.nsnumberstyle
    end
    NSNumberFormatter.localizedStringFromNumber(self, numberStyle:style)
  end

end
