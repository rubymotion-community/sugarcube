class UIButton

  def title
    titleForState(UIControlStateNormal)
  end

  def setTitle(value)
    setTitle(value, forState: UIControlStateNormal)
  end

end
