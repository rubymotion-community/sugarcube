class UIColor

  def to_s
    system_color = system_name
    return system_color if system_color

    inside = self.css_name || self.hex
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
    alpha_s = ((alpha || 1) < 1 ? "(#{alpha})" : '')
    if system_name
      return "UIColor.#{system_name}#{alpha_s}"
    elsif hex
      return "'#{hex}'.uicolor#{alpha_s}"
    elsif css_name
      return ":#{css_name}.uicolor#{alpha_s}"
    else
      super
    end
  end

end
