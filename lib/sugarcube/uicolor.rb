
class UIColor
  def uicolor ; self ; end

  def red
    _sugarcube_colors[:red]
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
      alpha = Pointer.new(:float)
      self.getRed(red, green:green, blue:blue, alpha:alpha)
      @color = {
        red: red[0],
        green: green[0],
        blue: blue[0],
        alpha: alpha[0],
      }
    end
  end

end