class Numeric

  ##|
  ##|  MISC
  ##|

  # Uses the screen scale to determine how many pixels (converts "pixels" to
  # "points")
  def pixels
    self.to_f / UIScreen.mainScreen.scale
  end
  alias pixel pixels

end
