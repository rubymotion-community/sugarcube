class NSString

  # @param font [UIFont] Optional, defaults to UIFont.systemFontOfSize(UIFont.systemFontSize)
  # @return [UILabel]
  def uilabel(font=nil)
    font ||= :system.uifont(UIFont.labelFontSize)
    size = self.sizeWithFont(font)
    UILabel.alloc.initWithFrame([[0, 0], size]).tap { |label|
      label.text = self
      label.font = font
      # why isn't this just the default!?
      label.backgroundColor = :clear.uicolor
    }
  end

end
