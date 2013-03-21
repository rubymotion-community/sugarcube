class UIColor

  def to_s
    alpha_s = ((alpha || 1) < 1 ? "(#{alpha})" : '')
    system_color = system_name
    return "UIColor.#{system_color}#{alpha_s}" if system_color

    alpha_s = ((alpha || 1) < 1 ? ", alpha: #{alpha}" : '')
    inside = (css_name && ":#{css_name}") || (hex && "'#{hex}'")
    if inside
      return "UIColor.color(#{inside}#{alpha_s})"
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
