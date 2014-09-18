class UIView

  def sugarcube_to_s(options={})
    suffix = ''
    # teacup
    if self.respond_to?(:stylename) && self.stylename && self.stylename.length > 0
      suffix += " stylename: #{self.stylename.inspect}"
    end
    # motionkit
    if self.respond_to?(:motion_kit_ids) && self.motion_kit_ids && self.motion_kit_ids.length > 0
      if motion_kit_ids.length == 1
        suffix += " motion_kit_id: #{self.motion_kit_id.inspect}"
      else
        suffix += " motion_kit_ids: #{self.motion_kit_ids.inspect}"
      end
    end
    # rmq?

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
