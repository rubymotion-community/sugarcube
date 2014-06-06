class NSImage

  # @return [NSColor]
  def nscolor(alpha=nil)
    color = NSColor.colorWithPatternImage(self)
    if not alpha.nil?
      color = color.colorWithAlphaComponent(alpha.to_f)
    end

    color
  end

  def cgcolor(alpha=nil)
    nscolor(alpha).CGColor
  end

  def skcolor(alpha=nil)
    nscolor(alpha)
  end

end
