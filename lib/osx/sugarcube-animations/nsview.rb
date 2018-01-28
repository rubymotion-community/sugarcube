class NSView

  class << self

    # This is an internal helper method to determine the animation options.
    def sugarcube_animation_options(options)
      {}
    end

    def animate(options={}, more_options={}, &animations)
      raise "animation block is required" unless animations

      if options.is_a? Numeric
        duration = options
        options = more_options
      else
        duration = options[:duration] || 0.3
      end

      delay = options[:delay] || 0

      after_animations = options[:after]

      animation_options = sugarcube_animation_options(options)
      if duration == 0 && delay == 0
        animations.call
        after_adjusted.call(true) if after_adjusted
      else
        NSAnimationContext.runAnimationGroup(-> (context) do
          context.duration = duration
          animations.call
        end, completionHandler: after_animations)
      end
    end

  end

  def animate(options={}, more_options={}, &animations)
    if options.is_a? Numeric
      options = more_options.merge(duration: options)
    end

    self.wantsLayer = true
    if self.layerContentsRedrawPolicy == NSViewLayerContentsRedrawDuringViewResize
      self.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay
    end

    NSView.animate(options, &animations)
    return self
  end

  def show
    self.hidden = false
    return self
  end

  def hide
    self.hidden = true
    return self
  end

  # Changes the layer opacity.
  def fade(options={}, more_options={}, &after)
    if options.is_a? Numeric
      options = { opacity: options }
    end

    options[:after] = after

    self.animate(options) do
      self.animator.alpha = options[:opacity]
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

end
