class UITextView

  def sugarcube_callbacks
    @sugarcube_callbacks ||= Hash.new { |h,k| h[k] = [] }
  end

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
