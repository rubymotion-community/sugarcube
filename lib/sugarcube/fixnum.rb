

class Fixnum

  #     0xffffff.uicolor
  # =>
  #     UIColor.colorWithRed(1, green:1, red: 1, alpha:1)
  def uicolor
    red = ((self & 0xFF0000) >> 16).to_f / 255.0
    green = ((self & 0xFF00) >> 8).to_f / 255.0
    blue = (self & 0xFF).to_f / 255.0

    UIColor.colorWithRed(red, green:green, blue:blue, alpha:1.0)
  end

  def percent
    self.to_f.percent
  end

end
