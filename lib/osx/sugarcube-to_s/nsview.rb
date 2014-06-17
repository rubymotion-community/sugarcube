class NSView

  def sugarcube_to_s(options={})
    if self.respond_to? :stylename and self.stylename
      suffix = ' stylename: ' + self.stylename.inspect
    else
      suffix = ''
    end
    if options[:inner].is_a? Hash
      inner = ''
      options[:inner].each do |key, value|
        inner += ', ' if inner.length > 0
        inner += "#{key}: #{value.inspect}"
      end
    else
      inner = options[:inner]
    end

    "#{self.class.to_s}(##{self.object_id.to_s(16)}, [[#{frame.origin.x}, #{frame.origin.y}], [#{frame.size.width}, #{frame.size.height}]]" +
                        (inner ? ', ' + inner : '') +
                        ')' +
                        (options.fetch(:superview, true) && self.superview ? ", child of #{self.superview.class.to_s}(##{self.superview.object_id.to_s(16)})" : '') +
                        suffix
  end

  def to_s
    sugarcube_to_s
  end

end
