class WiggleAnimationController < UIViewController
  # Notes:
  # if @tapped is true, the "tap to add a box" message is not displayed,
  # otherwise it is displayed after 3 seconds of inactivity
  # if @wiggled is true, the "press to toggle wiggling" message is not
  # displayed, otherwise it is displayed
  attr :wiggled

  def viewDidLoad
    self.view.on_tap &method(:'tapped:')
    self.view.on_press_begin &method(:toggle_wiggle)

    3.later do
      unless @tapped
        @tap_label = 'Tap to add a box'.uilabel
        @tap_label.textColor = :white.uicolor
        @tap_label.textAlignment = :center.nstextalignment
        @tap_label.frame = self.view.bounds
        self.view << @tap_label
        @tap_label.alpha = 0
        @tap_label.fade_in
      end
    end
    @boxes = []
  end

  def tapped(gesture)
    @tapped = true

    location = gesture.locationInView(view)
    width = 10 + 90 * rand
    x = location.x - width / 2
    height = 10 + 90 * rand
    y = location.y - height / 2
    box = UIView.alloc.initWithFrame([[x, y], [width, height]])
    box.backgroundColor = UIColor.colorWithHue(rand, saturation: 0.8, brightness: 0.8, alpha: 1)
    if @wiggling
      box.wiggle
    end
    self.view << box
    @boxes << box
    if @tap_label
      @tap_label.fade_out_and_remove do
        3.later do
          unless @wiggled
            @wiggle_label = 'Long press to toggle the wiggling'.uilabel
            @wiggle_label.textColor = :white.uicolor
            @wiggle_label.textAlignment = :center.nstextalignment
            @wiggle_label.frame = self.view.bounds
            self.view << @wiggle_label
            @wiggle_label.alpha = 0
            @wiggle_label.fade_in
          end
        end
      end
      @tap_label = nil
    end
  end

  def toggle_wiggle
    if @wiggling
      @boxes.each &:dont_wiggle
    else
      @wiggled = true
      @boxes.each &:wiggle

      if @wiggle_label
        @wiggle_label.fade_out_and_remove
        @wiggle_label = nil
      end
    end
    @wiggling = !@wiggling
  end

end
