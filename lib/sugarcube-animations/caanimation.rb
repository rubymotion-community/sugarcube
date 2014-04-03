class CAAnimation

  class << self

    # If you pass a block, that block will be called at the end of the
    # animation.
    def basic(target, key_path, options={}, &block)
      animation = CABasicAnimation.animationWithKeyPath(key_path)
      animation.duration = options[:duration] if options[:duration]
      if options[:delegate]
        animation.delegate = options[:delegate]
      end

      if options.key?(:from) || options.key?(:to) || options.key?(:by)
        add_animation = options.fetch(:add, true)

        animation.fromValue = options[:from] if options[:from]
        animation.toValue = options[:to] if options[:to]
        animation.byValue = options[:by] if options[:by]
      else
        add_animation = options.fetch(:add, false)
      end

      if add_animation
        target.addAnimation(animation, forKey:key_path)
        target.setValue(options[:to], forKeyPath: key_path)
      end

      return animation
    end

    def keyframe(target, key_path, options={}, &block)
      timing_function = options.fetch(:timing, KCAMediaTimingFunctionLinear)
      fill_mode = options.fetch(:fill_mode, KCAFillModeForwards)
      remove_on_completion = options.fetch(:remove, true)

      animation = CAKeyframeAnimation.animationWithKeyPath(key_path)
      animation.timingFunction = CAMediaTimingFunction.functionWithName(timing_function)
      animation.duration = options[:duration] if options[:duration]
      animation.delegate = options[:delegate] if options[:delegate]
      animation.duration = duration
      animation.fillMode = fill_mode
      animation.removedOnCompletion = remove_on_completion

      if options.key?(:values)
        values = options.fetch(:values, true)
        animation.values = values
        add_animation = options.fetch(:add, true)
      else
        add_animation = options.fetch(:add, false)
      end

      if add_animation
        target.addAnimation(animation, forKey:key_path)
        if options[:values]
          target.setValue(options[:values].last, forKeyPath: key_path)
        end
      end

      return animation
    end

  end

end
