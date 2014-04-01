class NSString

  # @return [NSColor]
  def nscolor(alpha=nil)
    if self[0,1] == '#'
      if self.length == 4
        return (self[1] * 2 + self[2] * 2 + self[3] * 2).to_i(16).nscolor(alpha)
      end
      return self[1..-1].to_i(16).nscolor(alpha)
    end

    img = NSImage.imageNamed(self)
    img && img.nscolor(alpha)
  end

end
