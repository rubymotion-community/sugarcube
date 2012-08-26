class UIView

  def to_s
    "#{self.class.name}(##{self.object_id}, [[#{self.frame.origin.x}, #{self.frame.origin.y}],{#{self.frame.size.width} × #{self.frame.size.height}}], "\
                        "#{self.superview ? ' child of ' + self.superview.class.name + ' #' + self.superview.object_id.to_s : ''})"
  end

end
