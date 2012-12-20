# BubbleWrap has these same methods, but the logic and options are a little
# different. In the spirit of open source, I am blatantly copying their code,
# changing it to suit my needs, and offering it here
class UIView

  def on_tapped(taps_or_options=nil, &proc)
    taps = nil
    touches = nil

    if taps_or_options
      if taps_or_options.is_a? Hash
        taps = taps_or_options[:taps] || taps
        touches = taps_or_options[:touches] || touches
      else
        taps = taps_or_options
      end
    end

    recognizer = UITapGestureRecognizer.alloc.initWithTarget(self, action:'sugarcube_handle_gesture:')
    recognizer.numberOfTapsRequired = taps if taps
    recognizer.numberOfTouchesRequired = touches if touches
    sugarcube_add_gesture(proc, recognizer)
  end

  def on_pinched(direction_or_options=nil, &proc)
    recognizer = UIPinchGestureRecognizer.alloc.initWithTarget(self, action:'sugarcube_handle_gesture:')
    sugarcube_add_gesture(proc, recognizer)
  end

  def on_rotated(direction_or_options=nil, &proc)
    recognizer = UIRotationGestureRecognizer.alloc.initWithTarget(self, action:'sugarcube_handle_gesture:')
    sugarcube_add_gesture(proc, recognizer)
  end

  def on_swiped(direction_or_options=nil, &proc)
    direction = UISwipeGestureRecognizerDirectionRight
    touches = nil

    if direction_or_options
      if direction_or_options.is_a? Hash
        direction = direction_or_options[:direction] || direction
        touches = direction_or_options[:touches] || touches
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
    recognizer.numberOfTouchesRequired = touches if touches
    sugarcube_add_gesture(proc, recognizer)
  end

  def on_panned(direction_or_options=nil, &proc)
    recognizer = UIPanGestureRecognizer.alloc.initWithTarget(self, action:'sugarcube_handle_gesture:')
    sugarcube_add_gesture(proc, recognizer)
  end

  def on_pressed(duration_or_options=nil, &proc)
    duration = nil
    taps = nil
    touches = nil

    if duration_or_options
      if duration_or_options.is_a? Hash
        duration = duration_or_options[:duration] || duration
        taps = duration_or_options[:taps] || taps
        touches = duration_or_options[:touches] || touches
      else
        duration = duration_or_options
      end
    end

    recognizer = UILongPressGestureRecognizer.alloc.initWithTarget(self, action:'sugarcube_handle_gesture:')
    recognizer.minimumPressDuration = duration if duration
    recognizer.numberOfTapsRequired = taps if taps
    recognizer.numberOfTouchesRequired = touches if touches
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