class UIColor
  def uicolor ; self ; end
  alias cgcolor CGColor

  def red
    _sugarcube_colors[:red]
  end

  def cgcolor
    self.CGColor
  end

  def green
    _sugarcube_colors[:green]
  end

  def blue
    _sugarcube_colors[:blue]
  end

  def alpha
    _sugarcube_colors[:alpha]
  end

private
  def _sugarcube_colors
    @color ||= begin
      red = Pointer.new(:float)
      green = Pointer.new(:float)
      blue = Pointer.new(:float)
      white = Pointer.new(:float)
      alpha = Pointer.new(:float)
      if self.getRed(red, green:green, blue:blue, alpha:alpha)
        {
          red: red[0],
          green: green[0],
          blue: blue[0],
          alpha: alpha[0],
        }
      elsif self.getWhite(white, alpha:alpha)
        {
          red: white[0],
          green: white[0],
          blue: white[0],
          alpha: alpha[0],
        }
      end
    end
  end

end
