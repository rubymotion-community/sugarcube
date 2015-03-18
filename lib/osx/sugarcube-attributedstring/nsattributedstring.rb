class NSString

  def bold(size=nil)
    nsattributedstring.bold(size)
  end

  def monospace(size=nil)
    nsattributedstring.monospace(size)
  end

  def underline(underline_style=nil)
    if underline_style
      nsattributedstring.underline_style(underline_style)
    else
      nsattributedstring.underline
    end
  end

end


class NSAttributedString

  def sugarcube_nsattributedstring_dummy_method
    NSSuperscriptAttributeName
    nil
  end

  def bold(size=nil)
    size ||= NSFont.systemFontSize
    font = NSFont.boldSystemFontOfSize(size)
    self.font(font)
  end

  def font(value)
    value = value.nsfont if value.respond_to?(:nsfont)
    with_attributes({ NSFontAttributeName => value })
  end

  def monospace(size=nil)
    size ||= NSFont.systemFontSize
    font = NSFont.fontWithName('Courier New', size: size)
    self.font({ NSFontAttributeName => font })
  end

  def underline
    underline_style(NSSingleUnderlineStyle)
  end

  def underline_style(value)
    with_attributes({NSUnderlineStyleAttributeName => value})
  end

  def foreground_color(value)
    value = value.nscolor if value.respond_to?(:nscolor)
    with_attributes({ NSForegroundColorAttributeName => value })
  end
  alias color foreground_color

  def background_color(value)
    value = value.nscolor if value.respond_to?(:nscolor)
    with_attributes({ NSBackgroundColorAttributeName => value })
  end
  alias bg_color background_color

  def stroke_color(value)
    value = value.nscolor if value.respond_to?(:nscolor)
    with_attributes({ NSStrokeColorAttributeName => value })
  end

  def superscript(amount=nil)
    amount ||= 1
    with_attributes({ NSSuperscriptAttributeName => amount })
  end

  def subscript
    superscript(-1)
  end

  def letterpress
    with_attributes({ NSTextEffectAttributeName => NSTextEffectLetterpressStyle })
  end

end
