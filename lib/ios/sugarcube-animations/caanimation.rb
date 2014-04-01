class CAAnimation

  class << self

    private def _sugarcube_apply_animation_options(animation, options)
      animation.duration = options[:duration] if options.key?(:duration)
      animation.delegate = options[:delegate] if options.key?(:delegate)
      animation.speed = options[:speed] if options.key?(:speed)
      animation.repeatCount = options[:repeat] if options.key?(:repeat)
      animation.repeatCount = options[:repeat_count] if options.key?(:repeat_count)
      animation.repeatDuration = options[:repeat_duration] if options.key?(:repeat_duration)
      animation.removedOnCompletion = options.fetch(:remove, true)
    end

    # If you pass a block, that block will be called at the end of the
    # animation.
    def basic(key_path, options={}, &block)
      animation = CABasicAnimation.animationWithKeyPath(key_path)
      _sugarcube_apply_animation_options(animation, options)

      if options.key?(:from) || options.key?(:to) || options.key?(:by)
        animation.fromValue = options[:from] if options.key?(:from)
        animation.toValue = options[:to] if options.key?(:to)
        animation.byValue = options[:by] if options.key?(:by)
      end

      return animation
    end

    def keyframe(key_path, options={}, &block)
      timing_function = options.fetch(:timing, KCAMediaTimingFunctionDefault)
      if timing_function.is_a?(NSString)
        timing_function = CAMediaTimingFunction.functionWithName(timing_function)
      end
      fill_mode = options.fetch(:fill_mode, KCAFillModeForwards)

      animation = CAKeyframeAnimation.animationWithKeyPath(key_path)
      _sugarcube_apply_animation_options(animation, options)
      animation.timingFunction = timing_function
      animation.fillMode = fill_mode

      if options.key?(:values)
        animation.values = options[:values]
      elsif options.key?(:path)
        animation.path = options[:path]
      end

      return animation
    end

  end

end
