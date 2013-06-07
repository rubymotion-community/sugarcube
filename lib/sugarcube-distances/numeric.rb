class Numeric

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

end
