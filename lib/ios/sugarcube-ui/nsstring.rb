class NSString

  # @return [UIImage]
  def uiimage
    UIImage.imageNamed(self).tap do |retval|
      NSLog("No image named #{self}") unless retval
    end
  end

  # @return [UIFont]
  def uifont(size=nil)
    size ||= UIFont.systemFontSize
    UIFont.fontWithName(self, size:size)
  end

  # @param font [UIFont] Optional, defaults to UIFont.systemFontOfSize(UIFont.systemFontSize)
  # @return [UILabel]
  def uilabel(font=nil)
    font ||= :system.uifont(UIFont.labelFontSize)
    size = self.sizeWithFont(font)
    label = UILabel.alloc.initWithFrame([[0, 0], size])
    label.text = self
    label.font = font
    # why isn't this just the default!?
    label.backgroundColor = :clear.uicolor
    return label
  end

  # @return [UIImageView]
  def uiimageview
    self.uiimage.uiimageview
  end

end
