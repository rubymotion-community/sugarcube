class NSArray

  # [160, 210, 242].nscolor => 0xA0D2F2.nscolor
  def nscolor(alpha=1.0)
    red = self[0] / 255.0
    green = self[1] / 255.0
    blue = self[2] / 255.0
    if self[3]
      alpha = self[3]
    end
    NSColor.rgba(red, green, blue, alpha.to_f)
  end

  def cgcolor(alpha=nil)
    nscolor(alpha).CGColor
  end

  def skcolor(alpha=nil)
    nscolor(alpha)
  end

end
