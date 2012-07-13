

class UIView

  def <<(view)
    self.addSubview view
  end

  def to_s
    "{#{self.class.name} @ x: #{self.frame.origin.x} y:#{self.frame.origin.y}, "\
                        "#{self.frame.size.width}×#{self.frame.size.height}}"\
                        "#{self.superview ? ' child of ' + self.superview.class.name : ''}"
  end

  def fadeout(duration=0.3, options={}, &after)
    UIView.animateWithDuration(duration,
                         delay: options[:delay] || 0,
                       options: options[:options] || UIViewAnimationOptionCurveLinear,
                    animations: proc{
                                  self.layer.opacity = options[:opacity] || 0
                                }, completion:after
                              )
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
  end

  def delta_to(delta, duration=0.3, options={}, &after)
    f = self.frame
    delta = Point(delta)
    position = Point(f.origin)
    position.x += delta.x
    position.y += delta.y
    UIView.animateWithDuration(duration,
                         delay: options[:delay] || 0,
                       options: options[:options] || UIViewAnimationOptionCurveLinear,
                    animations: proc{
                                  f = self.frame
                                  f.origin = position
                                  self.frame = position
                                }, completion:after
                              )
  end

end
