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

  # Accepts two options: brightness (default: -0.5) and saturation (default: -0.2)
  # Returns a darkened version of the image.
  def darken(options={})
    filter_name = 'CIColorControls'
    filter_options = {
      inputBrightness: options[:brightness] || -0.5,
      inputSaturation: options[:saturation] || -0.2,
    }

    cg_input_image = CIImage.alloc.initWithImage(self)
    darken_filter = CIFilter.filterWithName(filter_name)
    raise Exception.new("Filter not found: #{filter_name}") unless darken_filter

    darken_filter.setDefaults
    darken_filter.setValue(cg_input_image, forKey:'inputImage')
    filter_options.each_pair do |key, value|
      darken_filter.setValue(value, forKey:key)
    end
    output = darken_filter.valueForKey('outputImage')

    context = CIContext.contextWithOptions(nil)
    cg_output_image = context.createCGImage(output, fromRect:output.extent)
    output_image = UIImage.imageWithCGImage(cg_output_image)

    return output_image
  end

  ##|
  ##|  resizableImageWithCapInsets
  ##|
  def tileable
    resizableImageWithCapInsets(UIEdgeInsetsZero, resizingMode:UIImageResizingModeTile)
  end

  def stretchable
    resizableImageWithCapInsets(UIEdgeInsetsZero, resizingMode:UIImageResizingModeStretch)
  end

end
