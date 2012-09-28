
class UIColor
  def uicolor ; self ; end

  def color
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

  def red
    self.color[:red]
  end

  def green
    self.color[:green]
  end

  def blue
    self.color[:blue]
  end

  def alpha
    self.color[:alpha]
  end


end