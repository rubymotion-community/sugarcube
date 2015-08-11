class Fixnum

  #     0xffeedd.nscolor
  # =>
  #     NSColor.colorWithRed(0xFF / 255.0, green: 0xEE / 255.0, blue: 0xDD / 255.0, alpha: 1.0)
  #     # ≈ NSColor.colorWithRed(1.0, green: 0.933, blue: 0.867, alpha: 1.0)
  #
  #     0xffeedd.nscolor(0.25)
  # =>
  #     NSColor.colorWithRed(0xFF / 255.0, green: 0xEE / 255.0, blue: 0xDD / 255.0, alpha: 0.25)
  #     # ≈ NSColor.colorWithRed(1.0, green: 0.933, blue: 0.867, alpha: 0.25)
  def nscolor(alpha=nil)
    alpha = 1.0 if alpha.nil?

    red = ((self & 0xFF0000) >> 16).to_f / 255.0
    green = ((self & 0xFF00) >> 8).to_f / 255.0
    blue = (self & 0xFF).to_f / 255.0

    NSColor.rgba(red, green, blue, alpha.to_f)
  end

  def cgcolor(alpha=nil)
    nscolor(alpha).CGColor
  end

  def skcolor(alpha=nil)
    nscolor(alpha)
  end

end
