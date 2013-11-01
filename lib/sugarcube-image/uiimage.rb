##|
##|  REALLY HANDY STUFF!
##|  many of these methods are translated from:
##|  <http://www.catamount.com/blog/uiimage-extensions-for-cutting-scaling-and-rotating-uiimages/>
##|  <http://www.catamount.com/forums/viewtopic.php?f=21&t=967>
##|
class UIImage

  class << self

    # Easily create a UIImage by using this factory method, and do your drawing
    # in a block.  The core graphics context will be passed to the block you
    # provide.  To create a canvas based on an image, use the instance method.
    #
    # @example
    #     white_square = UIImage.canvas([100, 100]) do |context|
    #       :white.uicolor.set
    #       CGContextAddRect(context, [[0, 0], [100, 100]])
    #       CGContextDrawPath(context, KCGPathFill)
    #     end
    # :size is required, :scale defaults to the screen scale, and :opaque is
    # false by default.
    #
    # The first argument can be a size, or an options dict
    def canvas(options_or_size={}, more_options={}, &block)
      if options_or_size.is_a?(NSDictionary)
        options = options_or_size
        size = options[:size]
      else
        options = more_options
        size = options_or_size
      end
      raise ":size is required in #{self.name}##canvas" unless size
      scale = options[:scale] || UIScreen.mainScreen.scale
      opaque = options.fetch(:opaque, false)

      UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
      block.call(UIGraphicsGetCurrentContext()) if block
      new_image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return new_image
    end

  end

  # Merges the two images.  The target is drawn first, `image` is drawn on top.
  # The two images are centered, and the maximum size is used so that both
  # images fit on the canvas.
  def <<(image)
    self.merge(image, at: :center, stretch: true)
  end

  # Draw an image on top of the receiver.  The `:at` option provides either an
  # absolute location (Array or CGPoint) or relative location (Symbol, one of
  # :top_left, :top, :top_right, :left, :center (default), :right, :bottom_left,
  # :bottom, :bottom_right).  The `:stretch` option increases the canvas so
  # there is room for both images, otherwise the target image's size is used.
  def merge(image, options={})
    image_position = options.fetch(:at, :center)
    stretch = options.fetch(:stretch, false)

    size = self.size
    if stretch
      if image.size.width > size.width
        size.width = image.size.width
      end
      if image.size.height > size.height
        size.height = image.size.height
      end
    end

    my_left = image_left = 0
    my_top = image_top = 0
    my_right = (size.width - self.size.width)
    my_bottom = (size.height - self.size.height)
    image_right = (size.width - image.size.width)
    image_bottom = (size.height - image.size.height)
    my_cx = my_right / 2.0
    my_cy = my_bottom / 2.0
    image_cx = image_right / 2.0
    image_cy = image_bottom / 2.0

    case image_position
    when :top_left, :topleft, :tl
      my_position = [my_right, my_bottom]
      image_position = [image_left, image_top]
    when :top, :t
      my_position = [my_cx, my_bottom]
      image_position = [image_cx, image_top]
    when :top_right, :topright, :tr
      my_position = [my_left, my_bottom]
      image_position = [image_right, image_top]
    when :left, :l
      my_position = [my_right, my_cy]
      image_position = [image_left, image_cy]
    when :center, :c
      my_position = [my_cx, my_cy]
      image_position = [image_cx, image_cy]
    when :right, :r
      my_position = [my_left, my_cy]
      image_position = [image_right, image_cy]
    when :bottom_left, :bottomleft, :bl
      my_position = [my_right, my_top]
      image_position = [image_left, image_bottom]
    when :bottom, :b
      my_position = [my_cx, my_top]
      image_position = [image_cx, image_bottom]
    when :bottom_right, :bottomright, :br
      my_position = [my_left, my_top]
      image_position = [image_right, image_bottom]
    end

    return self.draw(size: size, at: my_position) do
      image.drawAtPoint(image_position)
    end
  end

  # Returns a cropped UIImage.  The easiest way is to check for a CGImage
  # backing, but if this image uses a CIImage backing, we draw a new (cropped)
  # image.
  def crop(rect)
    rect = SugarCube::CoreGraphics::Rect(rect)
    if self.CGImage
      if self.scale > 1.0
        rect = CGRectMake(rect.origin.x * self.scale,
                          rect.origin.y * self.scale,
                          rect.size.width * self.scale,
                          rect.size.height * self.scale)
      end

      cgimage = CGImageCreateWithImageInRect(self.CGImage, rect)
      return UIImage.imageWithCGImage(cgimage, scale:self.scale, orientation:self.imageOrientation)
    else
      return self.canvas(size: rect.size) do |context|
        self.drawAtPoint(CGPoint.new(-rect.origin.x, -rect.origin.y))
      end
    end
  end

  ##|
  ##|  image scaling
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
  #   are: `[:top_left, :top, :top_right, :left, :center, :right, :bottom_left,
  #   :bottom, :bottom_right]` (if you forget the underscore, like
  #   `topleft`, that'll work, too)
  #  @param scale [Numeric] image scale
  # @return [UIImage]
  def scale_to_fill(new_size, options={})
    new_size = SugarCube::CoreGraphics::Size(new_size)
    position = options[:position] || :center
    scale = options[:scale] || self.scale

    my_size = self.size
    if new_size.width == my_size.width && new_size.height == my_size.height && self.scale == scale
      return self
    end

    # first, scale down; then we'll scale back up if we went too far
    if my_size.width > new_size.width
      my_size.height *= new_size.width / my_size.width
      my_size.width = new_size.width
    end

    if my_size.height > new_size.height
      my_size.width *= new_size.height / my_size.height
      my_size.height = new_size.height
    end

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
      max_x = my_size.width
      max_y = my_size.height
      mid_x = max_x / 2
      mid_y = max_y / 2
      case position
      when :top_left, :topleft, :tl
        position = CGPoint.new(min_x, min_y)
      when :top, :t
        position = CGPoint.new(mid_x, min_y)
      when :top_right, :topright, :tr
        position = CGPoint.new(max_x, min_y)
      when :left, :l
        position = CGPoint.new(min_x, mid_x)
      when :center, :c
        position = CGPoint.new(mid_x, mid_x)
      when :right, :r
        position = CGPoint.new(max_x, mid_x)
      when :bottom_left, :bottomleft, :bl
        position = CGPoint.new(min_x, max_y)
      when :bottom, :b
        position = CGPoint.new(mid_x, max_y)
      when :bottom_right, :bottomright, :br
        position = CGPoint.new(max_x, max_y)
      else
        raise "Unknown position #{position.inspect}"
      end
    else
      position = SugarCube::CoreGraphics::Point(position)
    end
    thumbnail_x = position.x * (new_size.width - my_size.width) / my_size.width
    thumbnail_y = position.y * (new_size.height - my_size.height) / my_size.height

    new_image = self.canvas(size: new_size) do
      thumbnail_rect = CGRect.new([0, 0], [0, 0])
      thumbnail_rect.origin = [thumbnail_x, thumbnail_y]
      thumbnail_rect.size  = my_size

      self.drawInRect(thumbnail_rect)
    end

    raise "could not scale image" unless new_image

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
    new_image = self.canvas(size: new_size) do |context|
      if background
        background = background.uicolor
        background.setFill
        CGContextAddRect(context, [[0, 0], new_size])
        CGContextDrawPath(context, KCGPathFill)
      end

      thumbnail_rect = CGRect.new([0, 0], [0, 0])
      thumbnail_rect.origin = thumbnail_point
      thumbnail_rect.size.width  = scaled_width
      thumbnail_rect.size.height = scaled_height

      self.drawInRect(thumbnail_rect)
    end

    raise "could not scale image" unless new_image

    return new_image
  end

  ##|
  ##|  image modifications
  ##|
  def rounded(corner_radius=5)
    return self.canvas do
      path = UIBezierPath.bezierPathWithRoundedRect([[0, 0], size], cornerRadius:corner_radius)
      path.addClip
      self.drawInRect([[0, 0], size])
    end
  end

  # Returns a CIImage with the filter applied to the receiver.  The return value
  # is a CIImage object, which also defines `|` to work the same way, so filters
  # can be chained.
  #
  # @example
  #   image = 'test'.uiimage
  #   new_image = image.apply_filter(CIFilter.gaussian_blur)
  def apply_filter(filter)
    filter.setValue(self.ciimage, forKey: 'inputImage')
    return filter.valueForKey('outputImage')
  end

  # Returns a CGImageRef. Alias for `CGImage`.
  def cgimage
    return self.CGImage
  end

  # Returns a CIImage.
  def ciimage
    return CIImage.imageWithCGImage(self.CGImage)
  end

  # Accepts two options: brightness (default: 0.0) and saturation (default: 0.0)
  # Returns a darkened version of the image.
  def darken(options={})
    filter_options = {
      'inputSaturation' => options[:saturation] || 0,
      'inputBrightness' => options[:brightness] || 0,
    }

    darken_filter = CIFilter.color_controls(filter_options)
    output = self.apply_filter(darken_filter)
    return UIImage.imageWithCIImage(output, scale:self.scale, orientation:self.imageOrientation)
  end

  # Apply a gaussian filter
  # @options radius, default: 10
  #
  # @example
  #   image.gaussian_blur(radius: 5)
  #   image.gaussian_blur(5)  # :radius is the default option
  def gaussian_blur(*args)
    output = self.apply_filter(CIFilter.gaussian_blur(*args))
    return UIImage.imageWithCIImage(output, scale:self.scale, orientation:self.imageOrientation)
  end

  # Apply a color overlay to the image (very practical with PNG button images)
  #
  # @example
  #   image.overlay(UIColor.redColor)
  def overlay(color)
    image_rect = CGRectMake(0, 0, self.size.width, self.size.height)
    new_image = nil

    UIImage.canvas(size: self.size, scale: self.scale) do |ctx|
      self.drawInRect(image_rect)

      CGContextSetFillColorWithColor(ctx, color.uicolor.CGColor)
      CGContextSetAlpha(ctx, 1)
      CGContextSetBlendMode(ctx, KCGBlendModeSourceAtop)
      CGContextFillRect(ctx, image_rect)

      image_ref = CGBitmapContextCreateImage(ctx)
      new_image = UIImage.imageWithCGImage(image_ref, scale:self.scale, orientation:self.imageOrientation)
    end

    return new_image
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

    return self.canvas(size: new_size) do |context|
      # Move the origin to the middle of the image so we will rotate and scale around the center.
      CGContextTranslateCTM(context, new_size.width / 2, new_size.height / 2)

      # Rotate the image context
      CGContextRotateCTM(context, radian)

      # otherwise it'll be upside down:
      CGContextScaleCTM(context, 1.0, -1.0)
      # Now, draw the rotated/scaled image into the context
      CGContextDrawImage(context, CGRectMake(-new_size.width / 2, -new_size.height / 2, new_size.width, new_size.height), self.CGImage)
    end
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

  def avg_color
    colorSpace = CGColorSpaceCreateDeviceRGB()
    rgba = Pointer.new(:uchar, 4)
    context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, KCGImageAlphaPremultipliedLast | KCGBitmapByteOrder32Big)

    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), self.CGImage)

    if rgba[3] > 0
        alpha = rgba[3] / 255.0
        multiplier = alpha / 255.0
        return UIColor.colorWithRed(rgba[0] * multiplier,
                              green:rgba[1] * multiplier,
                               blue:rgba[2] * multiplier,
                              alpha:alpha)
    else
        return UIColor.colorWithRed(rgba[0] / 255.0,
                              green:rgba[1] / 255.0,
                               blue:rgba[2] / 255.0,
                              alpha:rgba[3] / 255.0)
    end
  end

  def at_scale(scale)
    if scale == self.scale
      return self
    end

    new_size = self.size
    new_size.width = new_size.width * self.scale / scale
    new_size.height = new_size.height * self.scale / scale

    return self.canvas(size: new_size, scale: scale) do
      thumbnail_rect = CGRect.new([0, 0], new_size)
      self.drawInRect(thumbnail_rect)
    end
  end

  # Using the image as the background, you can use this method to draw anything
  # on top, like text or other images.
  def draw(options={}, &block)
    at = options[:at] || [0, 0]
    return self.canvas(options) do |context|
      self.drawAtPoint(at)
      block.call(context) if block
    end
  end

  # the first argument can be a size, or an options dict
  def canvas(options_or_size={}, more_options={}, &block)
    if options_or_size.is_a?(NSDictionary)
      options = options_or_size
    else
      options = more_options
      options[:size] = options_or_size
    end

    unless options[:size]
      options[:size] = self.size
    end

    unless options[:scale]
      options[:scale] = self.scale
    end

    self.class.canvas(options) do |context|
      block.call(context) if block
    end
  end

end
