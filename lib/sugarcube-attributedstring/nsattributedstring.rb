class NSString

  def bold(size=nil)
    font = :bold.uifont(size)
    nsattributedstring({NSFontAttributeName => font})
  end

  def italic(size=nil)
    font = :italic.uifont(size)
    nsattributedstring({NSFontAttributeName => font})
  end

  def monospace(size=nil)
    font = :monospace.uifont(size)
    nsattributedstring({NSFontAttributeName => font})
  end

  def underline(underline_style=nil)
    underline_style ||= NSUnderlineStyleSingle
    nsattributedstring({NSUnderlineStyleAttributeName => underline_style})
  end

  def nsattributedstring(attributes={})
    NSAttributedString.alloc.initWithString(self, attributes: attributes)
  end

  def attrd(attributes={})
    self.nsattributedstring(attributes)
  end

end


class NSMutableString

  def nsattributedstring(attributes={})
    NSMutableAttributedString.alloc.initWithString(self, attributes: attributes)
  end

end


class NSAttributedString

  def dummy
    # make sure NSAttributedString constants get compiled
    foo = NSFontAttributeName
    foo = NSParagraphStyleAttributeName
    foo = NSForegroundColorAttributeName
    foo = NSBackgroundColorAttributeName
    foo = NSLigatureAttributeName
    foo = NSKernAttributeName
    foo = NSStrikethroughStyleAttributeName
    foo = NSUnderlineStyleAttributeName
    foo = NSStrokeColorAttributeName
    foo = NSStrokeWidthAttributeName
    foo = NSShadowAttributeName
    foo = NSVerticalGlyphFormAttributeName
    # new iOS 7 text effects
    foo = NSTextEffectAttributeName
    foo = NSTextEffectLetterpressStyle
    # make sure alignments get compiled
    foo = NSLeftTextAlignment
    foo = NSRightTextAlignment
    foo = NSCenterTextAlignment
    foo = NSJustifiedTextAlignment
    foo = NSNaturalTextAlignment
    nil
  end

  def to_s
    string  # this is the name of the Cocoa method to return an NSString
  end

  def bold(size=nil)
    font = :bold.uifont(size)
    self.font(font)
  end

  def italic(size=nil)
    font = :italic.uifont(size)
    self.font(font)
  end

  def underline
    underline_style(NSUnderlineStyleSingle)
  end

  def font(value)
    with_attributes({NSFontAttributeName => value.uifont})
  end

  def paragraph_style(value)
    with_attributes({NSParagraphStyleAttributeName => value})
  end

  def foreground_color(value)
    with_attributes({NSForegroundColorAttributeName => value.uicolor})
  end
  alias color foreground_color

  def underline_style(value)
    with_attributes({NSUnderlineStyleAttributeName => value})
  end

  def background_color(value)
    with_attributes({NSBackgroundColorAttributeName => value.uicolor})
  end
  alias bg_color background_color

  def ligature(value)
    with_attributes({NSLigatureAttributeName => value})
  end

  def kern(value)
    with_attributes({NSKernAttributeName => value})
  end

  def stroke_width(value)
    with_attributes({NSStrokeWidthAttributeName => value})
  end

  def stroke_color(value)
    with_attributes({NSStrokeColorAttributeName => value.uicolor})
  end

  def strikethrough_style(value)
    with_attributes({NSStrikethroughStyleAttributeName => value})
  end

  def shadow(value)
    with_attributes({NSShadowAttributeName => value})
  end

  def vertical_glyph_form(value)
    with_attributes({NSVerticalGlyphFormAttributeName => value})
  end

  def letterpress
    with_attributes({NSTextEffectAttributeName => NSTextEffectLetterpressStyle})
  end

  def with_attributes(attributes)
    retval = NSMutableAttributedString.alloc.initWithAttributedString(self)
    retval.addAttributes(attributes, range:[0, self.length])
    retval
  end

  def nsattributedstring
    self
  end

  def attrd
    self.nsattributedstring
  end

  def +(attributedstring)
    NSMutableAttributedString.alloc.initWithAttributedString(self) + attributedstring.nsattributedstring
  end

end


class NSMutableAttributedString

  def with_attributes(attributes)
    self.addAttributes(attributes, range:[0, self.length])
    self
  end

  def +(attributedstring)
    self.appendAttributedString(attributedstring.nsattributedstring)
  end

end
