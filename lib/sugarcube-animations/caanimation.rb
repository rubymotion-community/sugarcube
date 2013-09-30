class CAAnimation

  class << self

    def basic(target, key_path, options={}, &block)
      corner_animation = CABasicAnimation.animationWithKeyPath(key_path)
      corner_animation.duration = options[:duration] if options[:duration]

      if options.key?(:from) && options.key?(:to)
        add_animation = options.fetch(:add, true)
        corner_animation.fromValue = options[:from]
        corner_animation.toValue = options[:to]

        if add_animation
          target.addAnimation(corner_animation, forKey:key_path)
          target.send("#{key_path}=", options[:to])
        end
      end
      block.call(corner_animation) if block
      return corner_animation
    end

  end

end
