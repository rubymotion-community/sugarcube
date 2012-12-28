# BubbleWrap has these same methods, but the logic and options are a little
# different. In the spirit of open source, I am blatantly copying their code,
# changing it to suit my needs, and offering it here
class UIView

  # A generic gesture adder, but accepts a block like the other gesture methods
  # @yield [recognizer] Handles the gesture event, and passes the recognizer instance to the block.
  # @param options [Hash] method/value pairs to call on the gesture.
  # @overload on_gesture(recognizer)
  #   Adds the gesture to the view, and yields the block when the gesture is recognized
  # @overload on_gesture(recognizer_class)
  #   Instantiates a gesture and adds it to the view.
  # @example Using a UIGestureRecognizer class
  #   view.on_gesture(UISwipeGestureRecognizer, direction: UISwipeGestureRecognizerDirectionLeft) { puts "swiped left" }
  # @example Using a UIGestureRecognizer instance
  #   gesture = UISwipeGestureRecognizer
  #   gesture.direction = UISwipeGestureRecognizerDirectionLeft
  #   view.on_gesture(gesture) { puts "swiped left" }
  def on_gesture(klass, options={}, &proc)
    if klass.is_a? UIGestureRecognizer
      recognizer = klass
      recognizer.addTarget(self, action:'sugarcube_handle_gesture:')
    else
      recognizer = klass.alloc.initWithTarget(self, action:'sugarcube_handle_gesture:')
    end

    options.each do |method, value|
      recognizer.send(method, value)
    end
    sugarcube_add_gesture(proc, recognizer)
  end

  # @yield [recognizer] Handles the gesture event, and passes the recognizer instance to the block.
  # @overload on_tap(taps)
  #   @param taps [Fixnum] Number of taps
  # @overload on_tap(options)
  #   @option options [Fixnum] :taps Number of taps before gesture is recognized
  #   @option options [Fixnum] :fingers Number of fingers before gesture is recognized
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

  # @yield [recognizer] Handles the gesture event, and passes the recognizer instance to the block.
  def on_pinch(&proc)
    recognizer = UIPinchGestureRecognizer.alloc.initWithTarget(self, action:'sugarcube_handle_gesture:')
    sugarcube_add_gesture(proc, recognizer)
  end

  # @yield [recognizer] Handles the gesture event, and passes the recognizer instance to the block.
  def on_rotate(&proc)
    recognizer = UIRotationGestureRecognizer.alloc.initWithTarget(self, action:'sugarcube_handle_gesture:')
    sugarcube_add_gesture(proc, recognizer)
  end

  # @yield [recognizer] Handles the gesture event, and passes the recognizer instance to the block.
  # @overload on_swipe(taps)
  #   @param direction [Fixnum] Direction of swipe
  # @overload on_swipe(options)
  #   @option options [Fixnum] :fingers Number of fingers before gesture is recognized
  #   @option options [Fixnum, Symbol] :direction Direction of swipe, as a UISwipeGestureRecognizerDirection constant or a symbol (`:left, :right, :up, :down`)
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

  # @yield [recognizer] Handles the gesture event, and passes the recognizer instance to the block.
  # @overload on_tap(taps)
  #   @param taps [Fixnum] Number of taps
  # @overload on_tap(options)
  #   @option options [Fixnum] :min_fingers Minimum umber of fingers for gesture to be recognized
  #   @option options [Fixnum] :max_fingers Maximum number of fingers for gesture to be recognized
  #   @option options [Fixnum] :fingers If min_fingers or max_fingers is not assigned, this will be the default.
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

    # if fingers is assigned, but not min/max, assign it as a default
    min_fingers ||= fingers
    max_fingers ||= fingers

    recognizer = UIPanGestureRecognizer.alloc.initWithTarget(self, action:'sugarcube_handle_gesture:')
    recognizer.maximumNumberOfTouches = min_fingers if min_fingers
    recognizer.minimumNumberOfTouches = max_fingers if max_fingers
    sugarcube_add_gesture(proc, recognizer)
  end

  # @yield [recognizer] Handles the gesture event, and passes the recognizer instance to the block.
  # @overload on_press(duration)
  #   @param duration [Fixnum] How long in seconds before gesture is recognized
  # @overload on_tap(options)
  #   @option options [Fixnum] :duration How long in seconds before gesture is recognized
  #   @option options [Fixnum] :taps Number of taps before gesture is recognized
  #   @option options [Fixnum] :fingers Number of fingers before gesture is recognized
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
