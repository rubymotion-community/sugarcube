class NSString

  def bold(size=nil)
    font = :bold.nsfont(size)
    nsattributedstring({ NSFontAttributeName => font })
  end

  def monospace(size=nil)
    font = :monospace.nsfont(size)
    nsattributedstring({ NSFontAttributeName => font })
  end

  def underline(underline_style=nil)
    underline_style ||= NSSingleUnderlineStyle
    nsattributedstring({ NSUnderlineStyleAttributeName => underline_style })
  end

end


class NSAttributedString

  def sugarcube_nsattributedstring_dummy_method
    NSSuperscriptAttributeName
    nil
  end

  def bold(size=nil)
    font = :bold.nsfont(size)
    self.font(font)
  end

  def font(value)
    with_attributes({ NSFontAttributeName => value.nsfont })
  end

  def underline
    underline_style(NSSingleUnderlineStyle)
  end

  def underline_style(value)
    with_attributes({NSUnderlineStyleAttributeName => value})
  end

  def foreground_color(value)
    with_attributes({ NSForegroundColorAttributeName => value.nscolor })
  end
  alias color foreground_color

  def background_color(value)
    with_attributes({ NSBackgroundColorAttributeName => value.nscolor })
  end
  alias bg_color background_color

  def stroke_color(value)
    with_attributes({ NSStrokeColorAttributeName => value.nscolor })
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
