class UIView

  class << self

    # returns the first responder, starting at the Window and searching every subview
    def first_responder
      UIApplication.sharedApplication.keyWindow.first_responder
    end

    def attr_updates(*attrs)
      attr_accessor(*attrs)
      attrs.each do |attr|
        define_method("#{attr}=") do |value|
          if instance_variable_get("@#{attr}") != value
            setNeedsDisplay
          end
          instance_variable_set("@#{attr}", value)
        end
      end
    end

  end

  # superview << view
  # => superview.addSubview(view)
  def <<(view)
    self.addSubview(view)
    return self
  end

  def unshift(view)
    self.insertSubview(view, atIndex:0)
    return self
  end

  # returns the first responder, or nil if it cannot be found
  def first_responder
    if self.firstResponder?
      return self
    end

    found = nil
    self.subviews.each do |subview|
      found = subview.first_responder
      break if found
    end

    return found
  end

  # returns the nearest nextResponder instance that is a UIViewController. Goes
  # up the responder chain until the nextResponder is a UIViewController
  # subclass, or returns nil if none is found.
  def controller
    if nextResponder && nextResponder.is_a?(UIViewController)
      nextResponder
    elsif nextResponder
      nextResponder.controller
    else
      nil
    end
  end

   # Easily take a snapshot of a `UIView`.
   #
   # Calling `uiimage` with no arguments will return the image based on the
   # `bounds` of the image.  In the case of container views (notably
   # `UIScrollView` and its children) this does not include the entire contents,
   # which is something you probably want.
   #
   # If you pass a truthy value to this method, it will use the `contentSize` of
   # the view instead of the `bounds`, and it will draw all the child views, not
   # just those that are visible in the viewport.
   #
   # It is guaranteed that `true` and `:all` will always have this behavior.  In
   # the future, if this argument becomes something that accepts multiple values,
   # those two are sacred.
  def uiimage(use_content_size=false)
    if self.is_a?(UIScrollView) && (! self.window || ! self.window.keyWindow?)
      NSLog("For whatever reason, UIView#uiimage doesn't work on scrollviews unless they are already visible")
      return nil
    end

    if use_content_size
      rect = CGRect.new([0, 0], self.contentSize)
    else
      rect = self.layer.bounds
    end
    scale = (self.window ? self.window.screen : UIScreen.mainScreen).scale
    old_bounds = self.layer.bounds
    self.layer.bounds = rect
    UIGraphicsBeginImageContextWithOptions(rect.size, false, scale)
    context = UIGraphicsGetCurrentContext()
    if self.respond_to?('drawViewHierarchyInRect:afterScreenUpdates:')
      self.drawViewHierarchyInRect(CGRect.new([0, 0], rect.size), afterScreenUpdates: true)
    else
      CGContextSaveGState(context)
      CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y)
      layer.renderInContext(UIGraphicsGetCurrentContext())
      CGContextRestoreGState(context)
    end
    image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    self.layer.bounds = old_bounds
    return image
  end

  # Returns the receiver's bounds in the coordinate system of `destination`
  def convert_bounds(destination)
    message = "The (ambiguously named) `convert_bounds` method has been deprecated, use `convert_frame_to` (or `convert_frame_from`)"
    if defined?(SugarCube::Legacy)
      SugarCube::Legacy.log(message)
    else
      NSLog(message)
    end
    return convert_frame_to(destination)
  end

  def convert_frame_to(destination)
    return self.convertRect(CGRectMake(0, 0, self.frame.size.width, self.frame.size.height), toView:destination)
  end

  def convert_frame_from(source)
    return self.convertRect(CGRectMake(0, 0, source.frame.size.width, source.frame.size.height), fromView:source)
  end

  # Returns the receiver's bounds in the coordinate system of `destination`
  def convert_origin(destination)
    message = "The (ambiguously named) `convert_origin` method has been deprecated, use `convert_origin_to` (or `convert_origin_from`)"
    if defined?(SugarCube::Legacy)
      SugarCube::Legacy.log(message)
    else
      NSLog(message)
    end
    return self.convert_origin_to(destination)
  end

  def convert_origin_to(destination)
    return self.convertPoint([0, 0], toView:destination)
  end

  def convert_origin_from(source)
    return self.convertPoint([0, 0], fromView:source)
  end

  # Easily get and set a UIView's frame properties

  def x
    self.frame.origin.x
  end

  def setX(newX)
    newFrame = self.frame
    newFrame.origin.x = newX
    self.frame = newFrame
  end

  def y
    self.frame.origin.y
  end

  def setY(newY)
    newFrame = self.frame
    newFrame.origin.y = newY
    self.frame = newFrame
  end

  def height
    self.frame.size.height
  end

  def setHeight(newHeight)
    newFrame = self.frame
    newFrame.size.height = newHeight
    self.frame = newFrame
  end

  def width
    self.frame.size.width
  end

  def setWidth(newWidth)
    newFrame = self.frame
    newFrame.size.width = newWidth
    self.frame = newFrame
  end

end
