class CIImage

  def uiimage(scale=nil, orientation=nil)
    if scale
      orientation ||= UIImageOrientationUp
      return UIImage.imageWithCIImage(self, scale: scale, orientation: orientation)
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

end
