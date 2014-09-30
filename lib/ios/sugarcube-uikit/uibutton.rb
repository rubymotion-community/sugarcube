class UIButton

  def title
    titleForState(UIControlStateNormal)
  end

  def title=(value)
    setTitle(value)
  end

  def setTitle(value)
    setTitle(value, forState: UIControlStateNormal)
  end

  def attr_text
    attributedTitleForState(UIControlStateNormal)
  end

  def attr_text=(value)
    setAttributedTitle(value)
  end

  def setAttributedTitle(value)
    setAttributedTitle(value, forState: UIControlStateNormal)
  end

  def font=(value)
    self.titleLabel.font = value
  end
end
