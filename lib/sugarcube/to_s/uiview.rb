class UIView

  def to_s(options={})
    options[:superview] = true if options[:superview].nil?
    "#{self.class.name}(##{self.object_id.to_s(16)}, #{SugarCube::Adjust::format_frame(self.frame)}" +
                        (options[:inner] ? ', ' + options[:inner] : '') +
                        ')' +
                        (options[:superview] && self.superview ? ",  child of #{self.superview.class.name}(##{self.superview.object_id.to_s(16)})" : '')
  end

end
