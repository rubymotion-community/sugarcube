class UIColor
  def to_s
    system_color = nil
    Symbol.uicolors.each_pair do |color, method|
      if UIColor.send(method) == self
        if self.alpha < 1
          system_color = "UIColor.#{method}(#{alpha})"
        else
          system_color = "UIColor.#{method}"
        end
        break
      end
    end
    return system_color if system_color

    if self.red && self.green && self.blue
      red = (self.red * 255).round << 16
      green = (self.green * 255).round << 8
      blue = (self.blue * 255).round
      my_color = red + green + blue

      inside = my_color.to_s(16)
      inside = '0x' + '0' * (6 - inside.length)

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
