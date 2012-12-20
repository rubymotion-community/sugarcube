# BubbleWrap has these same methods, but the logic and options are a little
# different. In the spirit of open source, I am blatantly copying their code,
# changing it to suit my needs, and offering it here
class UIView

  def on_tap(taps_or_options=nil, &proc)
    taps = nil
    fingers = nil

    if taps_or_options
      if taps_or_options.is_a? Hash
        taps = taps_or_options[:taps] || taps
        fingers = taps_or_options[:fingers] || fingers
      else
        taps = taps_or_options
      end
    end

    recognizer = UITapGestureRecognizer.alloc.initWithTarget(self, action:'sugarcube_handle_gesture:')
    recognizer.numberOfTapsRequired = taps if taps
    recognizer.numberOfTouchesRequired = fingers if fingers
    sugarcube_add_gesture(proc, recognizer)
  end

  def on_pinch(&proc)
    recognizer = UIPinchGestureRecognizer.alloc.initWithTarget(self, action:'sugarcube_handle_gesture:')
    sugarcube_add_gesture(proc, recognizer)
  end

  def on_rotate(&proc)
    recognizer = UIRotationGestureRecognizer.alloc.initWithTarget(self, action:'sugarcube_handle_gesture:')
    sugarcube_add_gesture(proc, recognizer)
  end

  def on_swipe(direction_or_options=nil, &proc)
    direction = UISwipeGestureRecognizerDirectionRight
    fingers = nil

    if direction_or_options
      if direction_or_options.is_a? Hash
        direction = direction_or_options[:direction] || direction
        fingers = direction_or_options[:fingers] || fingers
      else
        direction = direction_or_options
      end
    end

    case direction
    when :left
      direction = UISwipeGestureRecognizerDirectionLeft
    when :right
      direction = UISwipeGestureRecognizerDirectionRight
    when :up
      direction = UISwipeGestureRecognizerDirectionUp
    when :down
      direction = UISwipeGestureRecognizerDirectionDown
    end

    recognizer = UISwipeGestureRecognizer.alloc.initWithTarget(self, action:'sugarcube_handle_gesture:')
    recognizer.direction = direction if direction
    recognizer.numberOfTouchesRequired = fingers if fingers
    sugarcube_add_gesture(proc, recognizer)
  end

  def on_pan(fingers_or_options=nil, &proc)
    fingers = nil
    min_fingers = nil
    max_fingers = nil

    if fingers_or_options
      if fingers_or_options.is_a? Hash
        fingers = fingers_or_options[:fingers] || fingers
        min_fingers = fingers_or_options[:min_fingers] || min_fingers
        max_fingers = fingers_or_options[:max_fingers] || max_fingers
      else
        fingers = fingers_or_options
      end
    end

    recognizer = UIPanGestureRecognizer.alloc.initWithTarget(self, action:'sugarcube_handle_gesture:')
    sugarcube_add_gesture(proc, recognizer)
  end

  def on_press(duration_or_options=nil, &proc)
    duration = nil
    taps = nil
    fingers = nil

    if duration_or_options
      if duration_or_options.is_a? Hash
        duration = duration_or_options[:duration] || duration
        taps = duration_or_options[:taps] || taps
        fingers = duration_or_options[:fingers] || fingers
      else
        duration = duration_or_options
      end
    end

    recognizer = UILongPressGestureRecognizer.alloc.initWithTarget(self, action:'sugarcube_handle_gesture:')
    recognizer.minimumPressDuration = duration if duration
    recognizer.numberOfTapsRequired = taps if taps
    recognizer.numberOfTouchesRequired = fingers if fingers
    sugarcube_add_gesture(proc, recognizer)
  end

private
  def sugarcube_handle_gesture(recognizer)
    handler = @sugarcube_recognizers[recognizer]
    if handler.arity == 0
      handler.call
    else
      handler.call(recognizer)
    end
  end

  # Adds the recognizer and keeps a strong reference to the Proc object.
  def sugarcube_add_gesture(proc, recognizer)
    self.addGestureRecognizer(recognizer)

    @sugarcube_recognizers = {} unless @sugarcube_recognizers
    @sugarcube_recognizers[recognizer] = proc

    recognizer
  end

end