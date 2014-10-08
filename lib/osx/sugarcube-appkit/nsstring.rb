class NSString

  # @return [NSImage]
  def nsimage
    NSImage.imageNamed(self).tap do |retval|
      NSLog("No image named #{self}") unless retval
    end
  end

  # @return [NSFont]
  def nsfont(size=nil)
    size ||= NSFont.systemFontSize
    NSFont.fontWithName(self, size: size)
  end

  # @param font [NSFont] Optional, defaults to NSFont.systemFontOfSize(NSFont.systemFontSize)
  # @return [NSLabel]
  def nslabel(font=nil)
    font ||= :system.nsfont(NSFont.labelFontSize)
    size = self.sizeWithAttributes({ NSFontAttributeName => font })
    label = NSTextField.alloc.initWithFrame([[0, 0], size])
    label.bezeled = false
    label.drawsBackground = false
    label.editable = false
    label.selectable = false
    label.stringValue = self
    label.font = font
    return label
  end

  # @return [NSImageView]
  def nsimageview
    image_view = NSImageView.alloc.init
    image_view.image = self.nsimage
    frame = image_view.frame
    frame.size = image_view.intrinsicContentSize
    image_view.frame = frame
    return image_view
  end

end
