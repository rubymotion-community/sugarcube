class NSArray

  # [160, 210, 242].uicolor => 0xA0D2F2.uicolor
  def uicolor(alpha=1.0)
    red = self[0] / 255.0
    green = self[1] / 255.0
    blue = self[2] / 255.0
    UIColor.colorWithRed(red, green:green, blue:blue, alpha:alpha.to_f)
  end

end
