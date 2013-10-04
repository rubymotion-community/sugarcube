class CAAnimation

  class << self

    def basic(target, key_path, options={}, &block)
      corner_animation = CABasicAnimation.animationWithKeyPath(key_path)
      corner_animation.duration = options[:duration] if options[:duration]
      corner_animation.delegate = options[:delegate] if options[:delegate]

      if options.key?(:from) || options.key?(:to) || options.key?(:by)
        add_animation = options.fetch(:add, true)

        corner_animation.fromValue = options[:from] if options[:from]
        corner_animation.toValue = options[:to] if options[:to]
        corner_animation.byValue = options[:by] if options[:by]
      else
        add_animation = options.fetch(:add, false)
      end

      if add_animation
        target.addAnimation(corner_animation, forKey:key_path)
        target.send("#{key_path}=", options[:to])
      end

      block.call(corner_animation) if block
      return corner_animation
    end

  end

end
