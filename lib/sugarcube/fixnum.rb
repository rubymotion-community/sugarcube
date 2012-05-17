

class Fixnum

  #     0xffffff.uicolor
  # =>
  #     UIColor.colorWithRed(1, green:1, red: 1, alpha:1)
  def uicolor
    red = ((rgb_value & 0xFF0000) >> 16).to_f / 255.0
    green = ((rgb_value & 0xFF00) >> 8).to_f / 255.0
    blue = (rgb_value & 0xFF).to_f / 255.0

    UIColor.colorWithRed(red, green:green, blue:blue, alpha:1.0)
  end

  def percent
    self.to_f.percent
  end

end
