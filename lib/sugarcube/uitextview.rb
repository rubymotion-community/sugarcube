class UITextView

  def sugarcube_callbacks
    @sugarcube_callbacks ||= Hash.new { |h,k| h[k] = [] }
  end
  def finish_callbacks
    self.sugarcube_callbacks[:finish]
  end
  def change_callbacks
    self.sugarcube_callbacks[:change]
  end

  def on(*events, &block)
    events.each do |event|
      case event
      when :change, UITextViewTextDidChangeNotification
        onFinish(&block)
      when :editing_did_end, UITextViewTextDidEndEditingNotification
        onChange(&block)
      else
        raise "Unknown or unsupported event #{event} in UITextView#on"
      end
    end

    self
  end

  def off(*events)
    events.each do |event|
      case event
      when :change, UITextViewTextDidChangeNotification
        offFinish
      when :editing_did_end, UITextViewTextDidEndEditingNotification
        offChange
      else
        raise "Unknown or unsupported event #{event} in UITextView#on"
      end
    end

    self
  end

  def onFinish(&block)
    notication = UITextViewTextDidEndEditingNotification
    self.sugarcube_callbacks[:finish] << NSNotificationCenter.defaultCenter.addObserverForName(notication,
          object: self,
           queue: NSOperationQueue.mainQueue,
      usingBlock: block)
    self
  end

  def offFinish
    self.sugarcube_callbacks[:finish].each do |callback_observer|
      NSNotificationCenter.defaultCenter.removeObserver(callback_observer)
    end
    self
  end

  def onChange(&block)
    notication = UITextViewTextDidChangeNotification
    self.sugarcube_callbacks[:change] << NSNotificationCenter.defaultCenter.addObserverForName(notication,
          object: self,
           queue: NSOperationQueue.mainQueue,
      usingBlock: block)
    self
  end

  def offChange
    self.sugarcube_callbacks[:change].each do |callback_observer|
      NSNotificationCenter.defaultCenter.removeObserver(callback_observer)
    end
    self
  end

end
