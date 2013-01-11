class UIColor
  def uicolor ; self ; end

  def red
    _sugarcube_colors && _sugarcube_colors[:red]
  end

  def cgcolor
    self.CGColor
  end

  def green
    _sugarcube_colors && _sugarcube_colors[:green]
  end

  def blue
    _sugarcube_colors && _sugarcube_colors[:blue]
  end

  def alpha
    _sugarcube_colors && _sugarcube_colors[:alpha]
  end

  # returns the closest css name
  def css_name
    found = Symbol.css_colors.map { |key, val| [key, _sugarcube_color_compare(self, val.uicolor)] }.inject{|c1,c2| c1[1] < c2[1] ? c1 : c2 }
    threshold = 0.03
    if found[1] > 0.03
      nil
    else
      found[0]
    end
  end

private
  def _sugarcube_color_compare(c1, c2)
    return (c1.red - c2.red).abs + (c1.green - c2.green).abs + (c1.blue - c2.blue).abs
  end

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
      else
        nil
      end
    end
  end

end
