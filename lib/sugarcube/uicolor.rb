
class UIColor

  def to_s
    alpha = self.alpha.to_s

    Symbol.uicolors.each_pair do |color, method|
      if UIColor.send(method) == self
        return "UIColor.#{method}(#{alpha})"
      end
    end

    red = (self.red * 255).to_i << 16
    green = (self.green * 255).to_i << 8
    blue = (self.blue * 255).to_i
    my_color = red + green + blue
    Symbol.css_colors.each_pair do |color, hex|
      if hex == my_color
        return "UIColor.color(#{color.inspect}, #{alpha})"
      end
    end
    return "UIColor.color(#{red}, #{green}, #{blue}, #{alpha})"
  end

  def color
    if not @color
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
    @color
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