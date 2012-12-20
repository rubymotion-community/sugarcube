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
    UIImageView.alloc.initWithImage(self)
  end

  ##|
  ##|  REALLY HANDY STUFF!
  ##|  many of these methods are translated from:
  ##|  <http://www.catamount.com/blog/uiimage-extensions-for-cutting-scaling-and-rotating-uiimages/>
  ##|  <http://www.catamount.com/forums/viewtopic.php?f=21&t=967>
  ##|
  def in_rect(rect)
    # not necessary, since we don't modify/examine the rect
    # rect = SugarCube::CoreGraphics::Rect(rect)
    imageRef = CGImageCreateWithImageInRect(self.CGImage, rect)
    sub_image = UIImage.imageWithCGImage(imageRef)

    return sub_image
  end

  def scale_to(new_size)
    new_size = SugarCube::CoreGraphics::Size(new_size)

    sourceImage = self
    newImage = nil

    image_size = sourceImage.size
    width = image_size.width
    height = image_size.height

    target_width = new_size.width
    target_height = new_size.height

    scale_factor = 0.0
    scaled_width = target_width
    scaled_height = target_height

    thumbnail_point = CGPoint.new(0.0, 0.0)

    unless CGSizeEqualToSize(image_size, new_size)
      width_factor = target_width / width
      heightFactor = target_height / height

      if width_factor < heightFactor
        scale_factor = width_factor
      else
        scale_factor = heightFactor
      end

      scaled_width  = width * scale_factor
      scaled_height = height * scale_factor

      # center the image

      if width_factor < heightFactor
        thumbnail_point.y = (target_height - scaled_height) * 0.5
      elsif width_factor > heightFactor
        thumbnail_point.x = (target_width - scaled_width) * 0.5
      end
    end

    # this is actually the interesting part:

    UIGraphicsBeginImageContext(new_size)

    thumbnail_rect = CGRectZero
    thumbnail_rect.origin = thumbnail_point
    thumbnail_rect.size.width  = scaled_width
    thumbnail_rect.size.height = scaled_height

    sourceImage.drawInRect(thumbnail_rect)

    new_image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    raise "could not scale image"  unless new_image

    return new_image
  end

  def rounded(corner_radius=5)
    UIGraphicsBeginImageContext(size)
    path = UIBezierPath.bezierPathWithRoundedRect([[0, 0], size], cornerRadius:corner_radius)
    path.addClip
    self.drawInRect([[0, 0], size])
    new_image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return new_image
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
  ##|  rotate images
  ##|
  def rotate(angle_or_direction)
    case angle_or_direction
    when :left
      radian = -90.degrees
    when :right
      radian = 90.degrees
    when :flip
      radian = 180.degrees
    when Numeric
      radian = angle_or_direction
    else
      raise "Unknown angle/direction #{angle_or_direction.inspect}"
    end

    w = (self.size.width * Math.cos(radian)).abs + (self.size.height * Math.sin(radian)).abs
    h = (self.size.height * Math.cos(radian)).abs + (self.size.width * Math.sin(radian)).abs
    new_size = CGSize.new(w, h)
    new_size = self.size

    # Create the bitmap context
    UIGraphicsBeginImageContext(new_size)
    bitmap = UIGraphicsGetCurrentContext()

    # Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, new_size.width / 2, new_size.height / 2)

    # Rotate the image context
    CGContextRotateCTM(bitmap, radian)

    # otherwise it'll be upside down:
    CGContextScaleCTM(bitmap, 1.0, -1.0)
    # Now, draw the rotated/scaled image into the context
    CGContextDrawImage(bitmap, CGRectMake(-new_size.width / 2, -new_size.height / 2, new_size.width, new_size.height), self.CGImage)

    new_image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return new_image
  end

  ##|
  ##|  resizableImageWithCapInsets
  ##|
  def tileable(insets=UIEdgeInsetsZero)
    # not necessary, since we don't modify/examine the insets
    # insets = SugarCube::CoreGraphics::EdgeInsets(insets)
    resizableImageWithCapInsets(insets, resizingMode:UIImageResizingModeTile)
  end

  def stretchable(insets=UIEdgeInsetsZero)
    # not necessary, since we don't modify/examine the insets
    # insets = SugarCube::CoreGraphics::EdgeInsets(insets)
    resizableImageWithCapInsets(insets, resizingMode:UIImageResizingModeStretch)
  end

end
