class NSString

  # @return [UIImage]
  def uiimage
    UIImage.imageNamed(self).tap do |retval|
      NSLog("No image named #{self}") unless retval
    end
  end

  # @return [UIImageView]
  def uiimageview
    self.uiimage ? self.uiimage.uiimageview : UIImageView.alloc.initWithImage(nil)
  end

  # @return [UIFont]
  def uifont(size=nil)
    size ||= UIFont.systemFontSize
    UIFont.fontWithName(self, size:size)
  end

end
