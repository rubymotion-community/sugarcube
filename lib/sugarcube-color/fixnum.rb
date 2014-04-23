class Fixnum

  #     0xffffff.uicolor
  #     0xffffff.uicolor(0.33)
  # =>
  #     UIColor.colorWithRed(1.0, green:1.0, blue: 1.0, alpha:1.0)
  #     UIColor.colorWithRed(1.0, green:1.0, blue: 1.0, alpha:0.33)
  def uicolor(alpha=nil)
    alpha ||= 1.0

    red = ((self & 0xFF0000) >> 16).to_f / 255.0
    green = ((self & 0xFF00) >> 8).to_f / 255.0
    blue = (self & 0xFF).to_f / 255.0

    UIColor.colorWithRed(red, green:green, blue:blue, alpha:alpha.to_f)
  end

  def cgcolor(alpha=nil)
    self.uicolor(alpha).CGColor
  end

end
