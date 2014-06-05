class NSNumber

  ##|
  ##|  MISC
  ##|

  # Uses the screen scale to determine how many pixels (converts "pixels" to
  # "points")
  def pixels
    self.to_f / NSScreen.mainScreen.backingScaleFactor
  end
  alias pixel pixels

end
