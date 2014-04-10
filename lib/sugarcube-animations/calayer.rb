class CALayer

  def basic_animation(key_path, options={})
    animation = CAAnimation.basic(self, key_path, options)

    self.addAnimation(animation, forKey: key_path)
    if options.key?(:to)
      self.setValue(options[:to], forKeyPath: key_path)
    end

    return animation
  end

  def keyframe_animation(key_path, options={})
    animation = CAAnimation.keyframe(self, key_path, options)

    self.addAnimation(animation, forKey: key_path)
    if options.key?(:values)
      self.setValue(options[:values].last, forKeyPath: key_path)
    end

    return animation
  end

end
