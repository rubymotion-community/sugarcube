class UIButton

  def title
    titleForState(UIControlStateNormal)
  end

  def setTitle(value)
    setTitle(value, forState: UIControlStateNormal)
  end

  def titleColor
    titleColorForState(UIControlStateNormal)
  end
  alias title_color titleColor

  def setTitleColor(value)
    value = value.uicolor if value.respond_to?(:uicolor)
    setTitleColor(value, forState: UIControlStateNormal)
  end
  alias title_color= setTitleColor

  def attributedTitle
    attributedTitleForState(UIControlStateNormal)
  end
  alias attributed_title attributedTitle

  def setAttributedTitle(value)
    setAttributedTitle(value, forState: UIControlStateNormal)
  end
  alias attributed_title= setAttributedTitle

end
