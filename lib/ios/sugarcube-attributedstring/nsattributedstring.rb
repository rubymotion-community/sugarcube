class NSString

  def underline(underline_style=nil)
    underline_style ||= NSUnderlineStyleSingle
    nsattributedstring({ NSUnderlineStyleAttributeName => underline_style })
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

  def underline
    underline_style(NSUnderlineStyleSingle)
  end

  def underline_style(value)
    with_attributes({NSUnderlineStyleAttributeName => value})
  end

  def superscript(amount=nil)
    amount ||= 1
    with_attributes({ KCTSuperscriptAttributeName => amount })
  end

  def subscript
    superscript(-1)
  end

end
