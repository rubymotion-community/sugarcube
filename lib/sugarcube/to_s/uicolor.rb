class UIColor

  def to_i
    if self.red && self.green && self.blue
      red = (self.red * 255).round << 16
      green = (self.green * 255).round << 8
      blue = (self.blue * 255).round
      return red + green + blue
    else
      return nil
    end
  end

  def to_hex
    if my_color = self.to_i
      return '#' + my_color.to_s(16).rjust(6, '0')
    else
      nil
    end
  end

  def to_s
    system_color = nil
    Symbol.uicolors.each_pair do |color, method|
      if UIColor.send(method) == self
        if self.alpha && self.alpha < 1
          system_color = "UIColor.#{method}(#{alpha})"
        else
          system_color = "UIColor.#{method}"
        end
        break
      end
    end
    return system_color if system_color

    inside = self.to_hex
    if inside
      my_color = self.to_i
      Symbol.css_colors.each_pair do |color, hex|
        if hex == my_color
          inside = color.inspect
          break
        end
      end

      if self.alpha < 1
        return "UIColor.color(#{inside}, #{alpha})"
      else
        return "UIColor.color(#{inside})"
      end
    else
      super
    end
  end

end
