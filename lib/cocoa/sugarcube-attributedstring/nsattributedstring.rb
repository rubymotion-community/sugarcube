class NSString

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

  def sugarcube_nsattributedstring_dummy_method
    # make sure NSAttributedString constants get compiled
    NSFontAttributeName
    NSParagraphStyleAttributeName
    NSForegroundColorAttributeName
    NSBackgroundColorAttributeName
    NSLigatureAttributeName
    NSKernAttributeName
    NSStrikethroughStyleAttributeName
    NSUnderlineStyleAttributeName
    NSStrokeColorAttributeName
    NSStrokeWidthAttributeName
    NSShadowAttributeName
    NSVerticalGlyphFormAttributeName
    # new iOS 7 text effects
    NSTextEffectAttributeName
    NSTextEffectLetterpressStyle
    # make sure alignments get compiled
    NSLeftTextAlignment
    NSRightTextAlignment
    NSCenterTextAlignment
    NSJustifiedTextAlignment
    NSNaturalTextAlignment
    nil
  end

  def to_s
    string  # this is the name of the Cocoa method to return an NSString
  end

  def paragraph_style(value)
    with_attributes({ NSParagraphStyleAttributeName => value })
  end

  def ligature(value)
    with_attributes({ NSLigatureAttributeName => value })
  end

  def kern(value)
    with_attributes({ NSKernAttributeName => value })
  end

  def stroke_width(value)
    with_attributes({ NSStrokeWidthAttributeName => value })
  end

  def strikethrough_style(value)
    with_attributes({ NSStrikethroughStyleAttributeName => value })
  end

  def shadow(value)
    with_attributes({ NSShadowAttributeName => value })
  end

  def vertical_glyph_form(value)
    with_attributes({ NSVerticalGlyphFormAttributeName => value })
  end

  def with_attributes(attributes)
    retval = NSMutableAttributedString.alloc.initWithAttributedString(self)
    retval.addAttributes(attributes, range:[0, self.length])
    retval
  end

  def nsattributedstring(attributes=nil)
    if attributes.nil?
      self
    else
      self.with_attributes(attributes)
    end
  end

  def attrd(attributes=nil)
    self.nsattributedstring(attributes=nil)
  end

  def +(attributedstring)
    string = NSMutableAttributedString.alloc.initWithAttributedString(self)
    string.appendAttributedString(attributedstring.nsattributedstring)
    string
  end

end


class NSMutableAttributedString

  def with_attributes(attributes)
    self.addAttributes(attributes, range:[0, self.length])
    self
  end

  def <<(attributedstring)
    self.appendAttributedString(attributedstring.nsattributedstring)
  end

end
