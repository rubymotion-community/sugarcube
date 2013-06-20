class CIImage

  def uiimage(scale=nil, orientation=nil)
    if scale && orientation
      return UIImage.imageWithCIImage(self, scale: scale, orientation: orientation)
    elsif scale && scale.is_a?(UIImage)
      return UIImage.imageWithCIImage(self, scale: scale.scale, orientation: scale.imageOrientation)
    else
      return UIImage.imageWithCIImage(self)
    end
  end

  def ciimage
    return self
  end

  def apply_filter(filter)
    filter.setValue(self, forKey: 'inputImage')
    return filter.valueForKey('outputImage')
  end

  def |(filter)
    if CIFilter === filter
      apply_filter(filter)
    elsif filter == UIImage
      self.uiimage
    elsif filter == UIView || filter == UIImageView
      self.uiimage.uiimageview
    elsif filter == CIImage
      self
    end
  end

end
