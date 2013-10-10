class UITextView

  def sugarcube_callbacks
    @sugarcube_callbacks ||= Hash.new { |h,k| h[k] = [] }
  end

  # Add event handlers to UITextView, with the same syntax as `UIControl`
  # objects.  Present tense and past simple aliases are provided. (e.g.
  # `editing_did_change` and `change`)
  #
  # @example
  #   text_view = UITextView.alloc.initWithFrame([0, 0, 10, 10])
  #   text_view.on(:editing_did_change) { my_code }
  #   # alias:
  #   text_view.on(:change) { my_code }
  #   text_view.on(:editing_did_begin, :editing_did_end) { my_code }
  def on(*events, &block)
    events.each do |event|
      case event
      when :editing_did_begin, :begin, UITextViewTextDidBeginEditingNotification
        _onEventNotification(UITextViewTextDidBeginEditingNotification, &block)
      when :editing_did_change, :change, UITextViewTextDidChangeNotification
        _onEventNotification(UITextViewTextDidChangeNotification, &block)
      when :editing_did_end, :end, UITextViewTextDidEndEditingNotification
        _onEventNotification(UITextViewTextDidEndEditingNotification, &block)
      else
        raise "Unknown or unsupported event #{event} in UITextView#on"
      end
    end

    self
  end

  # Removes all events that were bound with `on`.  Present tense and past simple
  # aliases are provided. (e.g. `editing_did_change` and `change`)
  #
  # @example
  #   text_view.off(:change)
  #   # alias:
  #   text_view.off(:editing_did_change)
  #   text_view.off(:editing_did_begin, :editing_did_end)
  #   text_view.off  # all events
  def off(*events)
    if events.length == 0
      events = self.sugarcube_callbacks.keys
    end

    events.each do |event|
      case event
      when :editing_did_begin, :begin, UITextViewTextDidBeginEditingNotification
        _offEventNotification(UITextViewTextDidBeginEditingNotification)
      when :editing_did_change, :change, UITextViewTextDidChangeNotification
        _offEventNotification(UITextViewTextDidChangeNotification)
      when :editing_did_end, :end, UITextViewTextDidEndEditingNotification
        _offEventNotification(UITextViewTextDidEndEditingNotification)
      else
        raise "Unknown or unsupported event #{event} in UITextView#on"
      end
    end

    self
  end

private
  def _onEventNotification(notication, &block)
    self.sugarcube_callbacks[notication] << NSNotificationCenter.defaultCenter.addObserverForName(notication,
          object: self,
           queue: NSOperationQueue.mainQueue,
      usingBlock: block)
  end

  def _offEventNotification(nofication)
    self.sugarcube_callbacks[nofication].each do |callback_observer|
      NSNotificationCenter.defaultCenter.removeObserver(callback_observer)
    end
  end

end
