class UIImage
  def uiimage ; self ; end

  def uicolor(alpha=nil)
    color = UIColor.colorWithPatternImage(self)
    if not alpha.nil?
      color = color.colorWithAlphaComponent(alpha.to_f)
    end

    color
  end

  def uiimageview
    @uiimageview = UIImageView.alloc.initWithImage(self)
  end

  ##|
  ##|  REALLY HANDY STUFF!
  ##|
  def scale_to new_size
    UIGraphicsBeginImageContextWithOptions(new_size, false, 0.0)
    self.drawInRect([[0, 0], new_size])
    image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  end

  def rounded(corner_radius=5)
    UIGraphicsBeginImageContext(size)
    path = UIBezierPath.bezierPathWithRoundedRect([[0, 0], size], cornerRadius:corner_radius)
    path.addClip
    self.drawInRect([[0, 0], size])
    image = UIGraphicsGetImageFromCurrentImageContext()

    UIGraphicsEndImageContext()
    return image
  end

  def tileable
    resizableImageWithCapInsets(UIEdgeInsetsZero, resizingMode:UIImageResizingModeTile)
  end

  def stretchable
    resizableImageWithCapInsets(UIEdgeInsetsZero, resizingMode:UIImageResizingModeStretch)
  end

end
