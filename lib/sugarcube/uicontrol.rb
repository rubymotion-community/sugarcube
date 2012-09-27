class UIControl

  # event blocks need to be retained, and the addTarget method explicitly does
  # *not* retain `target`.  This makes sure that callbacks are retained by
  # pushing the block onto a stack.
  def sugarcube_callbacks
    @sugarcube_callbacks ||= Hash.new { |hash, key| hash[key] = [] }
  end

  # Add event handlers to UIControls.  See symbol.rb for the uicontrolevent
  # constant aliases.
  #
  # @example
  #   button = UIButton.alloc.initWithFrame([0, 0, 10, 10])
  #   button.on(:touch) { my_code }
  #   button.on(:touchupoutside, :touchcancel) { my_code }
  def on(*events, &block)
    events.each do |event|
      event = event.uicontrolevent unless event.is_a? Fixnum

      sugarcube_callbacks[event].push block
      addTarget(block, action: :call, forControlEvents:event)
    end

    self
  end

  # Removes all events that were bound with `on`.  See symbol.rb for the
  # uicontrolevent constant aliases.
  #
  # @example
  #   button.off(:touch)
  #   button.off(:touchupoutside, :touchcancel)
  #   button.off  # all events
  def off(*events)
    if events.length == 0
      events = sugarcube_callbacks.keys
    end

    events.each do |event|
      event = event.uicontrolevent unless event.is_a? Fixnum

      sugarcube_callbacks[event].each do |block|
        self.removeTarget(block, action: :call, forControlEvents:event)
      end
      sugarcube_callbacks.delete(event)
    end
    self
  end

end
