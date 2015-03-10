class NSString

  def bold(size=nil)
    font = :bold.uifont(size)
    nsattributedstring({ NSFontAttributeName => font })
  end

  def italic(size=nil)
    font = :italic.uifont(size)
    nsattributedstring({ NSFontAttributeName => font })
  end

  def monospace(size=nil)
    font = :monospace.uifont(size)
    nsattributedstring({ NSFontAttributeName => font })
  end

  def underline(underline_style=nil)
    underline_style ||= NSUnderlineStyleSingle
    nsattributedstring({ NSUnderlineStyleAttributeName => underline_style })
  end

  def color(color=nil)
    color ||= UIColor.blackColor
    nsattributedstring({ NSForegroundColorAttributeName => color })
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
    nil
  end

  def bold(size=nil)
    font = :bold.uifont(size)
    self.font(font)
  end

  def italic(size=nil)
    font = :italic.uifont(size)
    self.font(font)
  end

  def font(value)
    with_attributes({ NSFontAttributeName => value.uifont })
  end

  def underline
    underline_style(NSUnderlineStyleSingle)
  end

  def underline_style(value)
    with_attributes({NSUnderlineStyleAttributeName => value})
  end

  def foreground_color(value)
    with_attributes({ NSForegroundColorAttributeName => value.uicolor })
  end
  alias color foreground_color

  def background_color(value)
    with_attributes({ NSBackgroundColorAttributeName => value.uicolor })
  end
  alias bg_color background_color

  def stroke_color(value)
    with_attributes({ NSStrokeColorAttributeName => value.uicolor })
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

end
