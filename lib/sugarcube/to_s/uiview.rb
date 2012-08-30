class UIView

  def to_s
    "#{self.class.name}(##{self.object_id.to_s(16)}, #{self.frame}, " +
                        self.superview ? " child of #{self.superview.class.name}(##{self.superview.object_id.to_s(16)})" : ''
  end

end
