class Symbol

  def awesome_icon(options={})
    raise "the MotionAwesome gem is required to use sugarcube-awesome" unless defined? MotionAwesome
    text = MotionAwesome.hex_for_icon( MotionAwesome.xform_icon(self) )
    options[:size] ||= UIFont.systemFontSize
    awesome_attrs = {NSFontAttributeName => MotionAwesome.font(options[:size])}
    if options.key?(:color)
      awesome_attrs[NSForegroundColorAttributeName] = options[:color]
    end
    NSAttributedString.alloc.initWithString(text, attributes: awesome_attrs )
  end

end
