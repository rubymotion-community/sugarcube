class NSView

  class << self

    def attr_updates(*attrs)
      attr_accessor(*attrs)
      attrs.each do |attr|
        define_method("#{attr}=") do |value|
          if instance_variable_get("@#{attr}") != value
            setNeedsDisplay
          end
          willChangeValueForKey(attr)
          instance_variable_set("@#{attr}", value)
          didChangeValueForKey(attr)
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
    first_view = self.subviews.first
    if first_view
      self.addSubview(view, positioned: NSWindowAbove, relativeTo: first_view)
    else
      self.addSubview(view)
    end
    return self
  end

  # returns the first responder, or nil if it cannot be found
  def first_responder
    self.window && self.window.firstResponder
  end

  def convert_frame_to(destination)
    return self.convert_rect(CGRectMake(0, 0, self.frame.size.width, self.frame.size.height), to: destination)
  end

  def convert_frame_from(source)
    return self.convert_rect(CGRectMake(0, 0, source.frame.size.width, source.frame.size.height), from: source)
  end

  def convert_rect(rect, to: destination)
    return self.convertRect(rect, toView: destination)
  end

  def convert_rect(rect, from: source)
    return self.convertRect(rect, fromView: source)
  end

  def convert_origin_to(destination)
    return self.convert_point([0, 0], to: destination)
  end

  def convert_origin_from(source)
    return self.convert_point([0, 0], from: source)
  end

  def convert_point(point, to: destination)
    return self.convertPoint(point, toView: destination)
  end

  def convert_point(point, from: source)
    return self.convertPoint(point, fromView: source)
  end

end
