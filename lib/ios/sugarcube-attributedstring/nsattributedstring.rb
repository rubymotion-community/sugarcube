class NSString

  def bold(size=nil)
    nsattributedstring.bold(size)
  end

  def italic(size=nil)
    nsattributedstring.italic(size)
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

  def font(value=UIFont.systemFontOfSize(14))
    nsattributedstring.font(value)
  end

  def color(value=UIColor.blackColor)
    nsattributedstring.color(value)
  end

end


class NSAttributedString

  def sugarcube_nsattributedstring_dummy_method
    KCTCharacterShapeAttributeName
    KCTFontAttributeName
    KCTKernAttributeName
    KCTLigatureAttributeName
    KCTForegroundColorAttributeName
    KCTForegroundColorFromContextAttributeName
    KCTParagraphStyleAttributeName
    KCTStrokeWidthAttributeName
    KCTStrokeColorAttributeName
    KCTSuperscriptAttributeName
    KCTUnderlineColorAttributeName
    KCTUnderlineStyleAttributeName
    KCTVerticalFormsAttributeName
    KCTGlyphInfoAttributeName
    KCTRunDelegateAttributeName
    KCTParagraphStyleSpecifierMinimumLineHeight
    nil
  end

  def bold(size=nil)
    size ||= UIFont.systemFontSize
    font = UIFont.boldSystemFontOfSize(size)
    self.font(font)
  end

  def italic(size=nil)
    size ||= UIFont.systemFontSize
    font = UIFont.italicSystemFontOfSize(size)
    self.font(font)
  end

  def monospace(size=nil)
    size ||= UIFont.systemFontSize
    font = UIFont.fontWithName('Courier New', size: size)
    self.font(font)
  end

  def font(value)
    value = value.uifont if value.respond_to?(:uifont)
    with_attributes({ NSFontAttributeName => value })
  end

  def underline
    underline_style(NSUnderlineStyleSingle)
  end

  def underline_style(value)
    with_attributes({NSUnderlineStyleAttributeName => value})
  end

  def foreground_color(value)
    value = value.uicolor if value.respond_to?(:uicolor)
    with_attributes({ NSForegroundColorAttributeName => value })
  end
  alias color foreground_color

  def background_color(value)
    value = value.uicolor if value.respond_to?(:uicolor)
    with_attributes({ NSBackgroundColorAttributeName => value })
  end
  alias bg_color background_color

  def stroke_color(value)
    value = value.uicolor if value.respond_to?(:uicolor)
    with_attributes({ NSStrokeColorAttributeName => value })
  end

  def superscript(amount=nil)
    amount ||= 1
    with_attributes({ KCTSuperscriptAttributeName => amount })
  end

  def subscript
    superscript(-1)
  end

  def letterpress
    with_attributes({ NSTextEffectAttributeName => NSTextEffectLetterpressStyle })
  end

  def line_height(value)
    style = NSMutableParagraphStyle.new
    style.minimumLineHeight = value
    paragraph_style(style)
  end

end
