

class UIView

  def <<(view)
    self.addSubview view
  end

  def to_s
    "{#{self.class.name} @ x: #{self.frame.origin.x} y:#{self.frame.origin.y}, "\
                        "#{self.frame.size.width}×#{self.frame.size.height}}"\
                        "#{self.superview ? ' child of ' + self.superview.class.name : ''}"
  end

  def show
    self.hidden = false
    self
  end

  def hide
    self.hidden = true
    self
  end

  def fade_out(duration=0.3, options={}, &after)
    UIView.animateWithDuration(duration,
                         delay: options[:delay] || 0,
                       options: options[:options] || UIViewAnimationOptionCurveLinear,
                    animations: proc{
                                  self.layer.opacity = options[:opacity] || 0
                                }, completion:after
                              )
    self
  end

  def move_to(position, duration=0.3, options={}, &after)
    UIView.animateWithDuration(duration,
                         delay: options[:delay] || 0,
                       options: options[:options] || UIViewAnimationOptionCurveLinear,
                    animations: proc{
                                  f = self.frame
                                  f.origin = position
                                  self.frame = position
                                }, completion:after
                              )
    self
  end

  def delta_to(delta, duration=0.3, options={}, &after)
    f = self.frame
    delta = SugarCube::CoreGraphics::Point(delta)
    position = SugarCube::CoreGraphics::Point(f.origin)
    position.x += delta.x
    position.y += delta.y
    UIView.animateWithDuration(duration,
                         delay: options[:delay] || 0,
                       options: options[:options] || UIViewAnimationOptionCurveLinear,
                    animations: proc{
                                  f = self.frame
                                  f.origin = position
                                  self.frame = f
                                }, completion:after
                              )
    self
  end

  def slide(direction, duration=0.3, options={}, &after)
    size = UIScreen.mainScreen.bounds.size
    case direction
    when :left
      delta_to([-size.width, 0], duration, options, &after)
    when :right
      delta_to([+size.width, 0], duration, options, &after)
    when :up
      delta_to([0, -size.height], duration, options, &after)
    when :down
      delta_to([0, +size.height], duration, options, &after)
    else
      raise "Unknown direction #{direction.inspect}"
    end
    self
  end

end
