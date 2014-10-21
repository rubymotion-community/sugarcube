class CAAnimation

  class << self

    private def _sugarcube_apply_animation_options(animation, options)
      if options.key?(:delay)
        animation.beginTime = CACurrentMediaTime() + options[:delay]
      end
      animation.duration = options[:duration] if options.key?(:duration)
      animation.delegate = options[:delegate] if options.key?(:delegate)
      animation.speed = options[:speed] if options.key?(:speed)
      if options[:repeat] == true
        animation.repeatCount = Float::MAX
      elsif options.key?(:repeat)
        animation.repeatCount = options[:repeat]
      elsif options.key?(:repeat_count)
        animation.repeatCount = options[:repeat_count]
      end
      animation.repeatDuration = options[:repeat_duration] if options.key?(:repeat_duration)
      animation.removedOnCompletion = options.fetch(:remove, true)
      if options.key?(:timing)
        timing_function = options[:timing]
        if timing_function.is_a?(NSString)
          timing_function = CAMediaTimingFunction.functionWithName(timing_function)
        end
        animation.timingFunction = timing_function
      end
    end

    # If you pass a block, that block will be called at the end of the
    # animation.
    def basic(key_path, options={}, &block)
      animation = CABasicAnimation.animationWithKeyPath(key_path)
      _sugarcube_apply_animation_options(animation, options)
      fill_mode = options.fetch(:fill_mode, KCAFillModeForwards)
      animation.fillMode = fill_mode

      animation.fromValue = options[:from] if options.key?(:from)
      animation.toValue = options[:to] if options.key?(:to)
      animation.byValue = options[:by] if options.key?(:by)

      return animation
    end

    def keyframe(key_path, options={}, &block)
      timing_function = options.fetch(:timing, KCAMediaTimingFunctionDefault)
      fill_mode = options.fetch(:fill_mode, KCAFillModeForwards)

      animation = CAKeyframeAnimation.animationWithKeyPath(key_path)
      _sugarcube_apply_animation_options(animation, options)
      animation.fillMode = fill_mode

      if options.key?(:values)
        animation.values = options[:values]
      elsif options.key?(:path)
        path = options[:path]
        if path.is_a?(UIBezierPath)
          path = path.CGPath
        end
        animation.path = path
      end

      return animation
    end

  end

  def completion(&completion)
    if completion
      unless self.delegate.is_a?(SugarCubeAnimationDelegate)
        delegate = SugarCubeAnimationDelegate.new
        self.delegate = delegate
      end
      self.delegate.completion = completion.weak!
    elsif self.delegate.is_a?(SugarCubeAnimationDelegate)
      return self.delegate.completion
    end
  end

  def start(&start)
    if start
      unless self.delegate.is_a?(SugarCubeAnimationDelegate)
        delegate = SugarCubeAnimationDelegate.new
        self.delegate = delegate
      end
      self.delegate.start = start.weak!
    elsif self.delegate.is_a?(SugarCubeAnimationDelegate)
      return self.delegate.start
    end
  end

end


class SugarCubeAnimationDelegate
  attr_accessor :start
  attr_accessor :completion

  def animationDidStart
    @start && @start.call
  end

  def animationDidStop(anim, finished: finished)
    @completion && @completion.call(finished)
  end

end
