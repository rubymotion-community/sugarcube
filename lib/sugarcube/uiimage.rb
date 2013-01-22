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
  # @param rect [CGRect] the portion of the image to return
  # @return [UIImage]
  def in_rect(rect)
    imageRef = CGImageCreateWithImageInRect(self.CGImage, rect)
    sub_image = UIImage.imageWithCGImage(imageRef, scale:self.scale, orientation:self.imageOrientation)

    return sub_image
  end

  # Delegates to scale_to_fill(position: :center)
  def scale_to_fill(new_size)
    scale_to_fill(new_size, position: :center)
  end

  # Scales an image to fit within the given size, stretching one or both
  # dimensions so that it completely fills the area.   The current aspect ratio
  # is maintained.  If you want to place an image inside a container image, this
  # is the method to use.
  #
  # You can specify a `position` property, which can be a symbol or a point.  It
  # specifies where you want the image located if it has to be cropped.
  # Specifying the top-left corner will display the top-left corner of the
  # image, likewise specifing the bottom-right corner will display *that*
  # corner.  If you want the image centered, you can use the 'position-less'
  # version of this method (`scale_to_fit()`) or specify the point at the center
  # of the image (`scale_to_fit(size, position:[w/2, h/2])`), or use a symbol
  # (`scale_to_fit(size, position: :center)`).
  #
  # @param new_size [CGSize] Minimum dimensions of desired image.  The returned image is
  #   guaranteed to fit within these dimensions.
  # @param position [Symbol, CGPoint] Where to position the resized image. Valid symbols
  #   are: `[:topleft, :top, :topright, :left, :center, :right, :bottomleft,
  #   :bottom, :bottomright]` (if you forget and use an underscore, like
  #   `top_left`, that'll work, too)
  # @return [UIImage]
  def scale_to_fill(new_size, position:position)
    new_size = SugarCube::CoreGraphics::Size(new_size)
    my_size = self.size

    if my_size.width < new_size.width
      my_size.height *= new_size.width / my_size.width
      my_size.width = new_size.width
    end

    if my_size.height < new_size.height
      my_size.width *= new_size.height / my_size.height
      my_size.height = new_size.height
    end

    if self.size.width == my_size.width && self.size.height == my_size.height
      return self
    end

    if position.is_a?(Symbol)
      min_x = 0
      min_y = 0
      max_x = my_size.width;
      max_y = my_size.height;
      mid_x = max_x / 2
      mid_y = max_y / 2
      case position
      when :top_left, :topleft
        position = SugarCube::CoreGraphics::Point(min_x, min_y)
      when :top
        position = SugarCube::CoreGraphics::Point(mid_x, min_y)
      when :top_right, :topright
        position = SugarCube::CoreGraphics::Point(max_x, min_y)
      when :left
        position = SugarCube::CoreGraphics::Point(min_x, mid_x)
      when :center
        position = SugarCube::CoreGraphics::Point(mid_x, mid_x)
      when :right
        position = SugarCube::CoreGraphics::Point(max_x, mid_x)
      when :bottom_left, :bottomleft
        position = SugarCube::CoreGraphics::Point(min_x, max_y)
      when :bottom
        position = SugarCube::CoreGraphics::Point(mid_x, max_y)
      when :bottom_right, :bottomright
        position = SugarCube::CoreGraphics::Point(max_x, max_y)
      else
        raise "Unknown position #{position.inspect}"
      end
    else
      position = SugarCube::CoreGraphics::Point(position)
    end
    thumbnail_x = position.x * (new_size.width - my_size.width) / my_size.width
    thumbnail_y = position.y * (new_size.height - my_size.height) / my_size.height

    UIGraphicsBeginImageContextWithOptions(new_size, false, self.scale)
    thumbnail_rect = CGRectZero
    thumbnail_rect.origin = [thumbnail_x, thumbnail_y]
    thumbnail_rect.size  = my_size

    self.drawInRect(thumbnail_rect)

    new_image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    raise "could not scale image"  unless new_image

    return new_image
  end

  # This method is similar to `scale_to`, except it doesn't pad the image, it
  # just scales the image so that it will fit inside the new bounds.
  def scale_within(new_size)
    target_size = SugarCube::CoreGraphics::Size(new_size)
    image_size = self.size

    if CGSizeEqualToSize(target_size, self.size)
      return self
    end

    width = image_size.width
    height = image_size.height

    target_width = target_size.width
    target_height = target_size.height

    width_factor = target_width / width
    height_factor = target_height / height

    if width_factor < height_factor
      scale_factor = width_factor
    else
      scale_factor = height_factor
    end

    if scale_factor == 1
      return self
    end

    scaled_size = CGSize.new(width * scale_factor, height * scale_factor)
    return scale_to(scaled_size)
  end

  # Delegates to scale_to(background:), specifying background color of `nil`
  def scale_to(new_size)
    scale_to(new_size, background:nil)
  end

  # Scales an image to fit within the given size.  Its current aspect ratio is
  # maintained, but the image is padded so that it fills the entire area. If the
  # image is too small, it will be scaled up to fit. If you specify a
  # background that color will be used, otherwise the background will be
  # transparent.
  #
  # @param new_size [CGSize] Maximum dimensions of desired image.  The returned image is
  #   guaranteed to fit within these dimensions.
  # @param background [UIColor] Color to fill padded areas.  Default is transparent.
  # @return [UIImage]
  def scale_to(new_size, background:background)
    new_size = SugarCube::CoreGraphics::Size(new_size)

    image_size = self.size

    if CGSizeEqualToSize(image_size, new_size)
      return self
    end

    new_image = nil
    width = image_size.width
    height = image_size.height

    target_width = new_size.width
    target_height = new_size.height

    scale_factor = 0.0
    scaled_width = target_width
    scaled_height = target_height

    thumbnail_point = CGPoint.new(0.0, 0.0)
    width_factor = target_width / width
    height_factor = target_height / height

    if width_factor < height_factor
      scale_factor = width_factor
    else
      scale_factor = height_factor
    end

    scaled_width  = width * scale_factor
    scaled_height = height * scale_factor

    # center the image

    if width_factor < height_factor
      thumbnail_point.y = (target_height - scaled_height) * 0.5
    elsif width_factor > height_factor
      thumbnail_point.x = (target_width - scaled_width) * 0.5
    end

    # this is actually the interesting part:

    UIGraphicsBeginImageContextWithOptions(new_size, false, self.scale)

    if background
      background = background.uicolor
      context = UIGraphicsGetCurrentContext()
      background.setFill
      CGContextAddRect(context, [[0, 0], new_size])
      CGContextDrawPath(context, KCGPathFill)
    end

    thumbnail_rect = CGRectZero
    thumbnail_rect.origin = thumbnail_point
    thumbnail_rect.size.width  = scaled_width
    thumbnail_rect.size.height = scaled_height

    self.drawInRect(thumbnail_rect)

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
  # The mask image cannot have ANY transparency. Instead, transparent areas must
  # be white or some value between black and white. The more white a pixel is
  # the more transparent it becomes.
  #     black  .. white
  #     opaque .. transparent
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

  # Oddly enough, this method doesn't seem to have retina support
  def color_at(point)
    point = SugarCube::CoreGraphics::Point(point)
    point.x *= self.scale
    point.y *= self.scale

    # First get the image into your data buffer
    cgimage = self.CGImage
    width = CGImageGetWidth(cgimage)
    height = CGImageGetHeight(cgimage)
    bytes_per_pixel = 4
    bits_per_component = 8
    bytes_per_row = bytes_per_pixel * width
    @raw_data || begin
      color_space = CGColorSpaceCreateDeviceRGB()
      @raw_data = Pointer.new(:uchar, height * width * 4)
      context = CGBitmapContextCreate(@raw_data, width, height, bits_per_component, bytes_per_row, color_space, KCGImageAlphaPremultipliedLast | KCGBitmapByteOrder32Big)

      CGContextDrawImage(context, CGRectMake(0, 0, width, height), cgimage)
    end

    # Now @raw_data contains the image data in the RGBA8888 pixel format.
    xx = point.x.round
    yy = point.y.round
    byte_index = (bytes_per_row * yy) + xx * bytes_per_pixel
    red = @raw_data[byte_index]
    green = @raw_data[byte_index + 1]
    blue = @raw_data[byte_index + 2]
    alpha = @raw_data[byte_index + 3]
    return [red, green, blue].uicolor(alpha / 255.0)
  end

  def at_scale(scale)
    if scale == self.scale
      return self
    end

    new_size = self.size
    new_size.width = new_size.width * self.scale / scale
    new_size.height = new_size.height * self.scale / scale

    UIGraphicsBeginImageContextWithOptions(new_size, false, scale)
    thumbnail_rect = CGRect.new([0, 0], new_size)

    self.drawInRect(thumbnail_rect)

    new_image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return new_image
  end

end
