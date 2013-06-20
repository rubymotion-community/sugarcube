class CIImage

  def uiimage
    return UIImage.imageWithCIImage(self)
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
      apply_filter
    elsif filter == UIImage
      self.uiimage
    elsif filter == UIView || filter == UIImageView
      self.uiimage.uiimageview
    elsif filter == CIImage
      self
    end
  end

end
