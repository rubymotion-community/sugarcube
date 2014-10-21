class CALayer

  def sugarcube_to_s(options={})
    if options[:inner].is_a? Hash
      inner = ''
      options[:inner].each do |key, value|
        inner += ', ' if inner.length > 0
        inner += "#{key}: #{value.inspect}"
      end
    else
      inner = options[:inner]
    end

    "#{self.class.to_s}(##{self.object_id.to_s(16)}, [[#{frame.origin.x}, #{frame.origin.y}], [#{frame.size.width}, #{frame.size.height}]])"
  end

  def to_s
    sugarcube_to_s
  end

end
