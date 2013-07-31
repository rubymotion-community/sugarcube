class UIView

  class << self

    # returns the first responder, starting at the Window and searching every subview
    def first_responder
      UIApplication.sharedApplication.keyWindow.first_responder
    end

    def attr_updates(*attrs)
      attr_accessor(*attrs)
      attrs.each do |attr|
        define_method("#{attr}=") { |value|
          if instance_variable_get("@#{attr}") != value
            setNeedsDisplay
          end
          instance_variable_set("@#{attr}", value)
        }
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
    scale = UIScreen.mainScreen.scale
    if use_content_size
      UIGraphicsBeginImageContextWithOptions(contentSize, false, scale)
      context = UIGraphicsGetCurrentContext()
      subviews.each do |subview|
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, subview.frame.origin.x, subview.frame.origin.y)
        subview.layer.renderInContext(context)
        CGContextRestoreGState(context)
      end
      image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
    else
      UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale)
      layer.renderInContext(UIGraphicsGetCurrentContext())
      image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
    end
    return image
  end

end
