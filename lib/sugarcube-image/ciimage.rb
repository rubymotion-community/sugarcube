class CIImage

  def uiimage
    return UIImage.imageWithCIImage(self)
  end

  def ciimage
    return self
  end

  def |(filter)
    if filter == UIImage
      self.uiimage
    elsif filter == CIImage
      self
    else
      filter.setValue(self, forKey: 'inputImage')
      return filter.valueForKey('outputImage')
    end
  end

end
