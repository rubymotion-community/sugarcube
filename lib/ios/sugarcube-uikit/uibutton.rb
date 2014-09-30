class UIButton

  def title
    titleForState(UIControlStateNormal)
  end

  def setTitle(value)
    setTitle(value, forState: UIControlStateNormal)
  end

  def attributedTitle
    attributedTitleForState(UIControlStateNormal)
  end

  def setAttributedTitle(value)
    setAttributedTitle(value, forState: UIControlStateNormal)
  end

end
