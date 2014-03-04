class UIView

  class << self

    # If options is a Numeric, it is used as the duration.  Otherwise, duration
    # is an option, and defaults to 0.3.  All the transition methods work this
    # way.
    # @option options [Float] :duration Animation duration. default: 0.3
    # @option options [Float] :delay Delay before animations begin. default: 0
    # @option options [Float] :damping Enables the "spring" animation.  Value of 1.0 is a stiff spring.
    # @option options [Float] :velocity Used in a spring animation to set the initial velocity
    # @option options [Proc]  :after A block that is executed when the animation is complete, useful for chaining (though the `animation_chain` method is better!)
    # @option options [Fixnum] :options The options parameter that is passed to the UIView.animateWithDuration(...) method.  You can also use the more verbose options `:curve`, `:from_current`, and `:allow_interaction`
    # @option options [Fixnum] :curve The animation curve option. default: UIViewAnimationOptionCurveEaseIn
    # @option options [Boolean] :from_current Whether or not to have animations start from their current position (aka UIViewAnimationOptionBeginFromCurrentState)
    # @option options [Boolean] :allow_interaction aka UIViewAnimationOptionAllowUserInteraction
    def animate(options={}, more_options={}, &animations)
      raise "animation block is required" unless animations

      if options.is_a? Numeric
        duration = options
        options = more_options
      else
        duration = options[:duration] || 0.3
      end

      delay = options[:delay] || 0

      damping_ratio = options[:damping] || nil
      spring_velocity = options[:velocity] || 0.0

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

        if damping_ratio
          UIView.animateWithDuration( duration,
                               delay: delay,
              usingSpringWithDamping: damping_ratio,
               initialSpringVelocity: spring_velocity,
                             options: animation_options,
                          animations: animations,
                          completion: after_adjusted
                                    )
        else
          UIView.animateWithDuration( duration,
                               delay: delay,
                             options: animation_options,
                          animations: animations,
                          completion: after_adjusted
                                    )
        end
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

  def show
    self.hidden = false
    return self
  end

  def hide
    self.hidden = true
    return self
  end

  # Same as UIView##animate, but acts on self
  def animate(options={}, more_options={}, &animations)
    if options.is_a? Numeric
      options = more_options.merge(duration: options)
    end

    assign = options[:assign] || {}

    UIView.animate(options) do
      animations.call if animations

      assign.each do |key, value|
        self.send("#{key}=", value)
      end
    end
    return self
  end

  # Changes the layer opacity.
  def fade(options={}, more_options={}, &after)
    if options.is_a? Numeric
      options = { opacity: options }
    end

    options[:after] = after

    animate(options) do
      self.alpha = options[:opacity]
    end
  end

  # Changes the layer opacity to 0.
  # @see #fade
  def fade_out(options={}, more_options={}, &after)
    if options.is_a? Numeric
      options = more_options.merge(duration: options)
    end

    options[:opacity] ||= 0.0

    fade(options, &after)
  end

  # Changes the layer opacity to 1.
  # @see #fade
  def fade_in(options={}, more_options={}, &after)
    if options.is_a? Numeric
      options = more_options.merge(duration: options)
    end

    options[:opacity] ||= 1.0

    fade(options, &after)
  end

  # Changes the layer opacity to 0 and then removes the view from its superview
  # @see #fade_out
  def fade_out_and_remove(options={}, more_options={}, &after)
    if options.is_a? Numeric
      options = more_options.merge(duration: options)
    end

    original_opacity = self.alpha

    after_remove = proc do
      self.alpha = original_opacity
      removeFromSuperview
      after.call if after
    end

    fade_out(options, &after_remove)
  end

  def scale_to(scale, options={}, more_options={}, &after)
    if options.is_a? Numeric
      options = more_options.merge(duration: options)
    end

    if scale.is_a?(Numeric)
      scale_x = scale_y = scale
    else  # this could be an array, or CGSize; either way we'll use []
      scale_x = scale[0]
      scale_y = scale[1]
    end

    options[:after] = after

    animate(options) {
      radians = Math.atan2(self.transform.b, self.transform.a)
      # radians = self.valueForKeyPath('layer.transform.rotation.z')
      rotation_t = CGAffineTransformMakeRotation(radians)
      scale_t = CGAffineTransformMakeScale(scale_x, scale_y)
      self.transform = CGAffineTransformConcat(rotation_t, scale_t)
    }
  end

  def center_to(center, options={}, more_options={}, &after)
    if options.is_a? Numeric
      options = more_options.merge(duration: options)
    end

    options[:after] = after

    animate(options) {
      self.center = SugarCube::CoreGraphics::Point(center)
    }
  end

  def move_to(position, options={}, more_options={}, &after)
    if options.is_a? Numeric
      options = more_options.merge(duration: options)
    end

    options[:after] = after

    animate(options) do
      f = self.frame
      f.origin = SugarCube::CoreGraphics::Point(position)
      self.frame = f
    end
  end

  def delta_to(delta, options={}, more_options={}, &after)
    f = self.frame
    delta = SugarCube::CoreGraphics::Point(delta)
    position = SugarCube::CoreGraphics::Point(f.origin)
    to_position = CGPoint.new(position.x + delta.x, position.y + delta.y)
    move_to(to_position, options, more_options, &after)
    return self
  end

  def resize_to(size, options={}, more_options={}, &after)
    if options.is_a? Numeric
      options = more_options.merge(duration: options)
    end

    options[:after] = after

    animate(options) do
      f = self.frame
      f.size = SugarCube::CoreGraphics::Size(size)
      self.frame = f
    end
  end

  def reframe_to(frame, options={}, more_options={}, &after)
    if options.is_a? Numeric
      options = more_options.merge(duration: options)
    end

    options[:after] = after

    animate(options) do
      self.frame = frame
    end
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

    animate(options) do
      self.transform = CGAffineTransformMakeRotation(new_angle)
    end
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
      size ||= self.frame.size.width
      delta_to([-size, 0], options, &after)
    when :right
      size ||= self.frame.size.width
      delta_to([size, 0], options, &after)
    when :up
      size ||= self.frame.size.height
      delta_to([0, -size], options, &after)
    when :down
      size ||= self.frame.size.height
      delta_to([0, size], options, &after)
    else
      raise "Unknown direction #{direction.inspect}"
    end
    return self
  end

  # moves the view off screen, then animates it back on screen.  The movement
  # off screen happens immediately, so if you provide a `delay:` option, it will
  # only affect the movement back on screen.
  def slide_from(direction, options={}, more_options={}, &after)
    if options.is_a? Numeric
      size = options
      options = more_options
    else
      size = options[:size]
    end

    options[:from_current] = false unless options.key?(:from_current)
    window_size = UIApplication.sharedApplication.windows[0].frame.size

    case direction
    when :left
      size ||= window_size.width
      self.center = CGPoint.new(self.center.x - size, self.center.y)
      self.delta_to([size, 0], options, &after)
    when :right
      size ||= window_size.width
      self.center = CGPoint.new(self.center.x + size, self.center.y)
      self.delta_to([-size, 0], options, &after)
    when :top, :up
      size ||= window_size.height
      self.center = CGPoint.new(self.center.x, self.center.y - size)
      self.delta_to([0, size], options, &after)
    when :bottom, :down
      size ||= window_size.height
      self.center = CGPoint.new(self.center.x, self.center.y + size)
      self.delta_to([0, -size], options, &after)
    else
      raise "Unknown direction #{direction.inspect}"
    end
    return self
  end

  # Vibrates the target. You can trick this thing out to do other effects, like:
  # @example
  #   # wiggle
  #   view.shake(offset: 0.1, repeat: 2, duration: 0.5, keypath: 'transform.rotation')
  #   # slow nodding
  #   view.shake(offset: 20, repeat: 10, duration: 5, keypath: 'transform.translation.y')
  def shake(options={}, more_options={})
    if options.is_a? Numeric
      duration = options
      options = more_options
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
    return self
  end

  # this dummy method is needed to define the setDuration method
  def dummy
    self.setDuration(nil)
  end
  private :dummy

  # Moves the view off screen while slowly rotating it.
  #
  # Based on https://github.com/warrenm/AHAlertView/blob/master/AHAlertView/AHAlertView.m
  def tumble(options={}, more_options={}, &after)
    if options.is_a? Numeric
      default_duration = options
      options = more_options
    else
      default_duration = 0.3
    end

    options[:duration] ||= default_duration
    options[:options] ||= UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionBeginFromCurrentState
    reset_transform = self.transform
    reset_after = ->(finished) do
      self.transform = reset_transform
    end

    if after
      options[:after] = ->(finished) do
        reset_after.call(finished)

        if after.arity == 0
          after.call
        else
          after.call(finished)
        end
      end
    else
      options[:after] = reset_after
    end

    self.animate(options) do
      window = UIApplication.sharedApplication.windows[0]
      top = self.convertPoint([0, 0], toView:nil).y
      height = window.frame.size.height - top
      offset = CGPoint.new(0, height * 1.5)
      offset = CGPointApplyAffineTransform(offset, self.transform)
      self.transform = CGAffineTransformConcat(self.transform, CGAffineTransformMakeRotation(-Math::PI/4))
      self.center = CGPointMake(self.center.x + offset.x, self.center.y + offset.y)
    end
  end

  # Moves the view on screen while slowly rotating it.
  #
  # Based on https://github.com/warrenm/AHAlertView/blob/master/AHAlertView/AHAlertView.m
  def tumble_in(options={}, &after)
    if options.is_a? Numeric
      default_duration = options
      options = {}
    else
      default_duration = 0.3
    end

    reset_transform = self.transform
    reset_center = self.center

    options[:duration] ||= default_duration
    options[:options] ||= UIViewAnimationOptionCurveEaseOut
    options[:after] = after

    window = UIApplication.sharedApplication.windows[0]
    top = self.convertPoint([0, 0], toView:nil).y
    height = window.frame.size.height - top
    offset = CGPoint.new(0, height * -1.5)
    offset = CGPointApplyAffineTransform(offset, self.transform)
    self.transform = CGAffineTransformConcat(self.transform, CGAffineTransformMakeRotation(Math::PI/4))
    self.center = CGPointMake(self.center.x + offset.x, self.center.y + offset.y)

    self.animate(options) do
      self.transform = reset_transform
      self.center = reset_center
    end
  end

  # Moves the view backwards, similar to what Google has been doing a lot
  # recently
  def back_fiend!(options={}, more_options={})
    scale = options[:scale] || 0.5
    perspective = options[:perspective] || -0.0005
    size = options[:size] || -140

    UIView.animation_chain(duration:200.millisecs, options:UIViewAnimationOptionCurveLinear) {
      self.layer.transform = CATransform3DTranslate(CATransform3DScale(CATransform3D.new(1,0,0,0, 0,1,0,perspective, 0,0,1,0, 0,0,0,1), scale, scale, scale), 0, size, 0)
    }.and_then(duration:300.millisecs, options:UIViewAnimationOptionCurveLinear) {
      self.layer.transform = CATransform3DTranslate(CATransform3DScale(CATransform3DIdentity, scale, scale, scale), 0, size, 0)
    }.start
  end

  # restores the layer after a call to 'back_fiend!'
  def forward_fiend!(options={}, more_options={})
    UIView.animate(options) do
      self.layer.transform = CATransform3DIdentity
    end
  end

end
