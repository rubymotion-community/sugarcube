class UIImage

  # @return [UIColor]
  def uicolor(alpha=nil)
    color = UIColor.colorWithPatternImage(self)
    if alpha
      color = color.colorWithAlphaComponent(alpha.to_f)
    end

    color
  end

  def cgcolor(alpha=nil)
    self.uicolor(alpha).CGColor
  end

end
