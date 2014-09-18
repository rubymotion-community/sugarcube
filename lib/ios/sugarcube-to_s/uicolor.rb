class UIColor

  def to_s
    return super unless self.respond_to?(:alpha)

    alpha_s = ((alpha || 1) < 1 ? "(#{alpha})" : '')
    if system_name
      return "UIColor.#{system_name}#{alpha_s.length > 0 ? '.colorWithAlphaComponent' + alpha_s : ''}"
    elsif css_name
      return ":#{css_name}.uicolor#{alpha_s}"
    elsif hex
      return "'#{hex}'.uicolor#{alpha_s}"
    else
      super
    end
  end

end
