class CALayer

  def basic_animation(key_path, options={})
    animation = CAAnimation.basic(key_path, options)

    should_add = options.fetch(:add, true)
    if should_add
      if should_add.is_a?(NSString)
        name = should_add
      else
        name = key_path
      end

      self.addAnimation(animation, forKey: name)
    end

    if options.key?(:to)
      self.setValue(options[:to], forKeyPath: key_path)
    end

    return animation
  end

  def keyframe_animation(key_path, options={})
    animation = CAAnimation.keyframe(key_path, options)

    should_add = options.fetch(:add, true)
    if should_add
      if should_add.is_a?(NSString)
        name = should_add
      else
        name = key_path
      end
      self.addAnimation(animation, forKey: name)
    end

    if options.key?(:values)
      self.setValue(options[:values].last, forKeyPath: key_path)
    end

    return animation
  end

end
