class UIView

  class << self
    # returns the first responder, starting at the Window and searching every subview
    def first_responder
      UIApplication.sharedApplication.keyWindow.first_responder
    end
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

  def <<(view)
    self.addSubview view
    return self
  end

  def show
    self.hidden = false
    self
  end

  def hide
    self.hidden = true
    self
  end

  def _after_proc(after)
    if after
      proc{ |finished|
            if after.arity == 0
              after.call
            else
              after.call(finished)
            end
          }
    end
  end

  # If options is a Numeric, it is used as the duration.  Otherwise, duration
  # is an option, and defaults to 0.3.  All the transition methods work this
  # way.
  def fade_out(options={}, &after)
    if options.is_a? Numeric
      duration = options
      options = {}
    else
      duration = options[:duration] || 0.3
    end

    after = _after_proc(after)

    UIView.animateWithDuration(duration,
                         delay: options[:delay] || 0,
                       options: options[:options] || UIViewAnimationOptionCurveEaseInOut,
                    animations: proc{
                                  self.layer.opacity = options[:opacity] || 0

                                  if assign = options[:assign]
                                    assign.each_pair do |key, value|
                                      self.send("#{key}=", value)
                                    end
                                  end
                                }, completion:after
                              )
    self
  end

  def fade_in(options={}, &after)
    if options.is_a? Numeric
      duration = options
      options = {}
    else
      duration = options[:duration] || 0.3
    end

    options[:opacity] = 1.0
    fade_out(options, &after)
  end

  def move_to(position, options={}, &after)
    if options.is_a? Numeric
      duration = options
      options = {}
    else
      duration = options[:duration] || 0.3
    end

    after = _after_proc(after)

    UIView.animateWithDuration(duration,
                         delay: options[:delay] || 0,
                       options: options[:options] || UIViewAnimationOptionCurveEaseInOut,
                    animations: proc{
                                  f = self.frame
                                  f.origin = SugarCube::CoreGraphics::Point(position)
                                  self.frame = f

                                  if assign = options[:assign]
                                    assign.each_pair do |key, value|
                                      self.send("#{key}=", value)
                                    end
                                  end
                                }, completion:after
                              )
    self
  end

  def delta_to(delta, options={}, &after)
    f = self.frame
    delta = SugarCube::CoreGraphics::Point(delta)
    position = SugarCube::CoreGraphics::Point(f.origin)
    move_to(position + delta, options, &after)
    self
  end

  def slide(direction, options={}, &after)
    if options.is_a? Numeric
      options = {size: options}
    end

    case direction
    when :left
      size = options[:size] || self.bounds.size.width
      delta_to([-size, 0], options, &after)
    when :right
      size = options[:size] || self.bounds.size.width
      delta_to([+size, 0], options, &after)
    when :up
      size = options[:size] || self.bounds.size.height
      delta_to([0, -size], options, &after)
    when :down
      size = options[:size] || self.bounds.size.height
      delta_to([0, +size], options, &after)
    else
      raise "Unknown direction #{direction.inspect}"
    end
    self
  end

  def shake(options={})
    if options.is_a? Numeric
      duration = options
      options = {}
    else
      duration = options[:duration] || 0.3
    end

    offset = options[:offset] || 8
    repeat = options[:repeat] || 3
    duration /= repeat
    keypath = options[:keypath] || 'transform.translation.x'

    origin = 0
    left = -offset
    right = +offset

    animation = CAKeyframeAnimation.animationWithKeyPath(keypath)
    animation.duration = duration
    animation.repeatCount = repeat
    animation.values = [origin, left, right, origin]
    animation.keyTimes = [0, 0.25, 0.75, 1.0]
    self.layer.addAnimation(animation, forKey:'shake')
    self
  end

end
