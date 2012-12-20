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

  # If options is a Numeric, it is used as the duration.  Otherwise, duration
  # is an option, and defaults to 0.3.  All the transition methods work this
  # way.
  def self.animate(options={}, &animations)
    if options.is_a? Numeric
      duration = options
      options = {}
    else
      duration = options[:duration] || 0.3
    end

    after_animations = options[:after]
    if after_animations
      if after_animations.arity == 0
        after_adjusted = proc { |finished| after_animations.call }
      else
        after_adjusted = proc { |finished| after_animations.call(finished) }
      end
    else
      after_adjusted = nil
    end

    UIView.animateWithDuration( duration,
                         delay: options[:delay] || 0,
                       options: options[:options] || UIViewAnimationOptionCurveEaseInOut,
                    animations: proc,
                    completion: after_adjusted
                              )
    nil
  end

  # Same as UIView##animate, but acts on self
  def animate(options={}, &animations)
    if options.is_a? Numeric
      duration = options
      options = {}
    else
      duration = options[:duration] || 0.3
    end

    assign = options[:assign] || {}

    UIView.animate(options) {
      animations.call if animations

      assign.each_pair do |key, value|
        self.send("#{key}=", value)
      end
    }
    self
  end

  # Changes the layer opacity.
  def fade(options={}, &after)
    if options.is_a? Numeric
      options = { opacity: options }
    end

    options[:after] ||= after

    animate(options) {
      self.layer.opacity = options[:opacity]
    }
  end

  # Changes the layer opacity to 0.
  # @see #fade
  def fade_out(options={}, &after)
    if options.is_a? Numeric
      options = { duration: options }
    end

    options[:opacity] ||= 0.0

    fade(options, &after)
  end

  # Changes the layer opacity to 1.
  # @see #fade
  def fade_in(options={}, &after)
    if options.is_a? Numeric
      options = { duration: options }
    end

    options[:opacity] ||= 1.0

    fade(options, &after)
  end

  def move_to(position, options={}, &after)
    if options.is_a? Numeric
      options = { duration: options }
    end

    options[:after] ||= after

    animate(options) {
      f = self.frame
      f.origin = SugarCube::CoreGraphics::Point(position)
      self.frame = f
    }
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
    if repeat == Float::INFINITY
      duration = 0.1
    else
      duration /= repeat
    end
    keypath = options[:keypath] || 'transform.translation.x'

    origin = options[:origin] || 0
    left = origin - offset
    right = origin + offset

    animation = CAKeyframeAnimation.animationWithKeyPath(keypath)
    animation.duration = duration
    animation.repeatCount = repeat
    animation.values = [origin, left, right, origin]
    animation.keyTimes = [0, 0.25, 0.75, 1.0]
    self.layer.addAnimation(animation, forKey:'shake')
    self
  end

end
