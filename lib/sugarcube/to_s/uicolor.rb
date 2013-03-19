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
    my_color = self.to_i
    if my_color
      return '#' + my_color.to_s(16).rjust(6, '0')
    else
      nil
    end
  end

  def to_css
    my_color = self.to_i
    css_name = nil
    Symbol.css_colors.each_pair do |color, hex|
      if hex == my_color
        css_name = color.inspect
        break
      end
    end
    return css_name
  end

  def to_system
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
    return system_color
  end

  def to_s
    system_color = to_system
    return system_color if system_color

    inside = self.to_css || self.to_hex
    if inside
      if self.alpha < 1
        return "UIColor.color(#{inside}, #{alpha})"
      else
        return "UIColor.color(#{inside})"
      end
    else
      super
    end
  end

  def inspect
    alpha_s = (alpha < 1 ? "(#{alpha})" : '')
    if to_system
      return to_system
    elsif to_hex
      return "'#{to_hex}'.uicolor#{alpha_s}"
    elsif to_css
      return ":#{to_css}.uicolor#{alpha_s}"
    else
      super
    end
  end

end
