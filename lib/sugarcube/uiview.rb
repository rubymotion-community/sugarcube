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

    # If options is a Numeric, it is used as the duration.  Otherwise, duration
    # is an option, and defaults to 0.3.  All the transition methods work this
    # way.
    def animate(options={}, &animations)
      if options.is_a? Numeric
        duration = options
        options = {}
      else
        duration = options[:duration] || 0.3
      end

      delay = options[:delay] || 0

      # chain: true is used inside animation_chain blocks to prevent some weird
      # animation errors (nested animations do not delay/queue as you'd expect)
      if options[:chain] || Thread.current[:sugarcube_chaining]
        duration = 0
        delay = 0
        raise "Completion blocks cannot be used within an animation_chain block" if options[:after]
      end

      after_animations = options[:after]
      if after_animations
        if after_animations.arity == 0
          after_adjusted = ->(finished){ after_animations.call }
        else
          after_adjusted = after_animations
        end
      else
        after_adjusted = nil
      end

      animation_options = options[:options]
      unless animation_options
        curve = options.fetch(:curve, UIViewAnimationOptionCurveEaseInOut)
        curve = curve.uianimationcurve if curve.is_a?(Symbol)

        from_current = options.fetch(:from_current, true) ? UIViewAnimationOptionBeginFromCurrentState : 0
        allow_interaction = options.fetch(:allow_interaction, false) ? UIViewAnimationOptionAllowUserInteraction : 0

        animation_options = curve | from_current
      end

      if duration == 0 && delay == 0
        animations.call
        after_adjusted.call(true) if after_adjusted
      else
        prev_value = Thread.current[:sugarcube_chaining]
        Thread.current[:sugarcube_chaining] = true
        UIView.animateWithDuration( duration,
                             delay: delay,
                           options: animation_options,
                        animations: animations,
                        completion: after_adjusted
                                  )
        Thread.current[:sugarcube_chaining] = prev_value
      end
      nil
    end

    # Animation chains are great for consecutive animation blocks.  Each chain can
    # take the same options that UIView##animate take.
    def animation_chain(options={}, &first)
      chain = SugarCube::AnimationChain.new
      if first
        chain.and_then(options, &first)
      end
      return chain
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

  def show
    self.hidden = false
    self
  end

  def hide
    self.hidden = true
    self
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

    options[:after] = after

    animate(options) {
      self.alpha = options[:opacity]
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

  # Changes the layer opacity to 0 and then removes the view from its superview
  # @see #fade_out
  def fade_out_and_remove(options={}, &after)
    if options.is_a? Numeric
      options = { duration: options }
    end

    original_opacity = self.alpha

    after_remove = proc {
      self.alpha = original_opacity
      removeFromSuperview
      after.call if after
    }

    fade_out(options, &after_remove)
  end

  def move_to(position, options={}, &after)
    if options.is_a? Numeric
      options = { duration: options }
    end

    options[:after] = after

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
    to_position = CGPoint.new(position.x + delta.x, position.y + delta.y)
    move_to(to_position, options, &after)
    self
  end

  def resize_to(size, options={}, &after)
    if options.is_a? Numeric
      options = { duration: options }
    end

    options[:after] = after

    animate(options) {
      f = self.frame
      f.size = SugarCube::CoreGraphics::Size(size)
      self.frame = f
    }
  end

  def reframe_to(frame, options={}, &after)
    if options.is_a? Numeric
      options = { duration: options }
    end

    options[:after] = after

    animate(options) {
      self.frame = frame
    }
  end

  # Changes the current rotation to `new_angle`
  # (`rotate` rotates relative to the current rotation)
  def rotate_to(options={}, more_options={}, &after)
    if options.is_a? Numeric
      new_angle = options
      options = more_options
    else
      new_angle = options[:angle]
    end

    options[:after] = after

    animate(options) {
      self.transform = CGAffineTransformMakeRotation(new_angle)
    }
  end

  # Changes the current rotation by `new_angle`
  # (`rotate` rotates to a specific angle)
  def rotate(options={}, more_options={}, &after)
    if options.is_a? Numeric
      new_angle = options
      options = more_options
    else
      new_angle = options[:angle]
    end

    old_angle = valueForKeyPath('layer.transform.rotation.z')
    options[:angle] = old_angle + new_angle
    rotate_to(options, &after)
  end

  def slide(direction, options={}, more_options={}, &after)
    if options.is_a? Numeric
      size = options
      options = more_options
    else
      size = options[:size]
    end

    case direction
    when :left
      size ||= self.bounds.size.width
      delta_to([-size, 0], options, &after)
    when :right
      size ||= self.bounds.size.width
      delta_to([size, 0], options, &after)
    when :up
      size ||= self.bounds.size.height
      delta_to([0, -size], options, &after)
    when :down
      size ||= self.bounds.size.height
      delta_to([0, size], options, &after)
    else
      raise "Unknown direction #{direction.inspect}"
    end
    self
  end

  # Vibrates the target. You can trick this thing out to do other effects, like:
  # @example
  #   # wiggle
  #   view.shake(offset: 0.1, repeat: 2, duration: 0.5, keypath: 'transform.rotation')
  #   # slow nodding
  #   view.shake(offset: 20, repeat: 10, duration: 5, keypath: 'transform.translation.y')
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
    if keypath == 'transform.rotation'
      value_keypath = 'layer.transform.rotation.z'
    else
      value_keypath = keypath
    end

    if options[:from_current]
      origin = options[:origin] || valueForKeyPath(value_keypath)
    else
      origin = options[:origin] || 0
    end
    left = origin - offset
    right = origin + offset

    animation = CAKeyframeAnimation.animationWithKeyPath(keypath)
    animation.send(:'setDuration:', duration)
    animation.repeatCount = repeat
    animation.values = [origin, left, right, origin]
    animation.keyTimes = [0, 0.25, 0.75, 1.0]
    self.layer.addAnimation(animation, forKey:'shake')
    self
  end

  # this dummy method is needed to define the setDuration method
  def dummy
    self.setDuration(nil)
  end
  private :dummy

  # Moves the view off screen while slowly rotating it.
  #
  # Based on https://github.com/warrenm/AHAlertView/blob/master/AHAlertView/AHAlertView.m
  def tumble(options={}, &after)
    if options.is_a? Numeric
      default_duration = options
      options = {}
    else
      default_duration = 0.3
    end

    options[:duration] ||= default_duration
    options[:options] ||= UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionBeginFromCurrentState
    reset_transform = self.transform
    reset_after = ->(finished) {
      self.transform = reset_transform
    }

    if after
      options[:after] = ->(finished) {
        reset_after.call(finished)

        if after.arity == 0
          after.call
        else
          after.call(finished)
        end
      }
    else
      options[:after] = reset_after
    end

    self.animate(options) {
      window = UIApplication.sharedApplication.windows[0]
      top = self.convertPoint([0, 0], toView:nil).y
      height = window.frame.size.height - top
      offset = CGPoint.new(0, height * 1.5)
      offset = CGPointApplyAffineTransform(offset, self.transform)
      self.transform = CGAffineTransformConcat(self.transform, CGAffineTransformMakeRotation(-Math::PI/4))
      self.center = CGPointMake(self.center.x + offset.x, self.center.y + offset.y)
    }
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
