class UIImage
  def uiimage ; self ; end

  # @return [UIColor]
  def uicolor(alpha=nil)
    color = UIColor.colorWithPatternImage(self)
    if not alpha.nil?
      color = color.colorWithAlphaComponent(alpha.to_f)
    end

    color
  end

  # @return [UIImageView]
  def uiimageview
    UIImageView.alloc.initWithImage(self)
  end

  # @return [NSData] an NSData object in PNG format
  def nsdata
    UIImagePNGRepresentation(self)
  end

  ##|
  ##|  REALLY HANDY STUFF!
  ##|  many of these methods are translated from:
  ##|  <http://www.catamount.com/blog/uiimage-extensions-for-cutting-scaling-and-rotating-uiimages/>
  ##|  <http://www.catamount.com/forums/viewtopic.php?f=21&t=967>
  ##|

  # This method is used to crop an image.  Scale (retina or non-retina) is preserved.
  #
  # @param rect the portion of the image to return
  # @return [UIImage]
  def in_rect(rect)
    imageRef = CGImageCreateWithImageInRect(self.CGImage, rect)
    sub_image = UIImage.imageWithCGImage(imageRef, scale:self.scale, orientation:self.imageOrientation)

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
    UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
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
    output_image = UIImage.imageWithCGImage(cg_output_image, scale:self.scale, orientation:self.imageOrientation)

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
    UIGraphicsBeginImageContextWithOptions(new_size, false, self.scale)
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

  ##|
  ##|  imageWithAlignmentRectInsets
  ##|
  def alignment_rect(insets=UIEdgeInsetsZero)
    imageWithAlignmentRectInsets(insets)
  end

  ##|
  ##|  CGImageCreateWithMask
  ##|
  ## The mask image cannot have ANY transparency.
  ## Instead, transparent areas must be white or some value between black and white.
  ## The closer towards black a pixel is the less transparent it becomes.
  def masked(mask_image)
    mask_image = mask_image.CGImage

    width = CGImageGetWidth(mask_image)
    height = CGImageGetHeight(mask_image)
    component_bits = CGImageGetBitsPerComponent(mask_image)
    pixel_bits = CGImageGetBitsPerPixel(mask_image)
    row_bytes = CGImageGetBytesPerRow(mask_image)
    data_provider = CGImageGetDataProvider(mask_image)

    mask = CGImageMaskCreate(width, height, component_bits,
      pixel_bits, row_bytes, data_provider,nil, false)

    masked = CGImageCreateWithMask(self.CGImage, mask)
    UIImage.imageWithCGImage(masked, scale:self.scale, orientation:self.imageOrientation)
  end

end
