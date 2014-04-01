class Symbol

  def awesome_icon(options={})
    raise "the MotionAwesome gem is required to use sugarcube-awesome" unless defined? MotionAwesome
    text = MotionAwesome.hex_for_icon( MotionAwesome.xform_icon(self) )

    if options.key?(:size)
      font_size = options[:size]
      font_size = font_size.uifontsize if font_size.respond_to?(:uifontsize)
    else
      font_size = UIFont.systemFontSize
    end

    awesome_attrs = {NSFontAttributeName => MotionAwesome.font(font_size)}
    if options.key?(:color)
      awesome_attrs[NSForegroundColorAttributeName] = options[:color].uicolor
    end

    NSAttributedString.alloc.initWithString(text, attributes: awesome_attrs )
  end

end
