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
    UILabel.alloc.initWithFrame([[0, 0], size]).tap { |label|
      label.text = self
      label.font = font
      # why isn't this just the default!?
      label.backgroundColor = :clear.uicolor
    }
  end

  # @return [UIImageView]
  def uiimageview
    image = UIImage.imageNamed(self)
    unless image
      NSLog("No image named #{self}")
    end
    UIImageView.alloc.initWithImage(image)
  end

end
