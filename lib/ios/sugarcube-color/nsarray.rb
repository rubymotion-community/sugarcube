class NSArray

  # [160, 210, 242].uicolor => 0xA0D2F2.uicolor
  # [160, 210, 242, 0.5].uicolor => 0xA0D2F2.uicolor(0.5)
  def uicolor(alpha=nil)
    red = self[0] / 255.0
    green = self[1] / 255.0
    blue = self[2] / 255.0
    if self[3]
      alpha = self[3]
    end
    alpha ||= 1.0
    UIColor.colorWithRed(red, green: green, blue: blue, alpha: alpha.to_f)
  end

  def cgcolor(alpha=nil)
    uicolor(alpha).CGColor
  end

  def skcolor(alpha=nil)
    uicolor(alpha)
  end

end
