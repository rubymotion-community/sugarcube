class NSColor

  def to_s
    return super unless self.respond_to?(:alpha)

    alpha_s = ((alpha || 1) < 1 ? "(#{alpha})" : '')
    system_color = system_name
    return "NSColor.#{system_color}#{alpha_s}" if system_color

    alpha_s = ((alpha || 1) < 1 ? ", alpha: #{alpha}" : '')
    inside = (css_name && ":#{css_name}") || (hex && "'#{hex}'")
    if inside
      return "NSColor.color(#{inside}#{alpha_s})"
    else
      super
    end
  end

  def inspect
    return super unless self.respond_to?(:alpha)

    alpha_s = ((alpha || 1) < 1 ? "(#{alpha})" : '')
    if system_name
      return "NSColor.#{system_name}#{alpha_s}"
    elsif css_name
      return ":#{css_name}.uicolor#{alpha_s}"
    elsif hex
      return "'#{hex}'.uicolor#{alpha_s}"
    else
      super
    end
  end

end
