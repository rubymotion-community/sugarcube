class NSImage

  # @return [NSColor]
  def nscolor(alpha=nil)
    color = NSColor.colorWithPatternImage(self)
    if not alpha.nil?
      color = color.colorWithAlphaComponent(alpha.to_f)
    end

    color
  end

end
