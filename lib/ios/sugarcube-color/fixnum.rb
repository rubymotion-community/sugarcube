class Fixnum

  #     0xffeedd.uicolor
  # =>
  #     UIColor.colorWithRed(0xFF / 255.0, green: 0xEE / 255.0, blue: 0xDD / 255.0, alpha: 1.0)
  #     # ≈ UIColor.colorWithRed(1.0, green: 0.933, blue: 0.867, alpha: 1.0)
  #
  #     0xffeedd.uicolor(0.25)
  # =>
  #     UIColor.colorWithRed(0xFF / 255.0, green: 0xEE / 255.0, blue: 0xDD / 255.0, alpha: 0.25)
  #     # ≈ UIColor.colorWithRed(1.0, green: 0.933, blue: 0.867, alpha: 0.25)
  def uicolor(alpha=nil)
    alpha = 1.0 if alpha.nil?

    red = ((self & 0xFF0000) >> 16).to_f / 255.0
    green = ((self & 0xFF00) >> 8).to_f / 255.0
    blue = (self & 0xFF).to_f / 255.0

    UIColor.colorWithRed(red, green: green, blue: blue, alpha: alpha.to_f)
  end

  def cgcolor(alpha=nil)
    uicolor(alpha).CGColor
  end

  def skcolor(alpha=nil)
    uicolor(alpha)
  end

end
