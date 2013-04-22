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
  alias attrd nsattributedstring

end


class NSMutableString

  def nsattributedstring(attributes={})
    NSMutableAttributedString.alloc.initWithString(self, attributes: attributes)
  end

end


class NSAttributedString
  NSSuperscriptAttributeName = 'NSSuperscript'
  NSAttachmentAttributeName = 'NSAttachment'
  NSBaselineOffsetAttributeName = 'NSBaselineOffset'
  NSLinkAttributeName = 'NSLink'
  NSUnderlineColorAttributeName = 'NSUnderlineColor'
  NSStrikethroughColorAttributeName = 'NSStrikethroughColor'
  NSObliquenessAttributeName = 'NSObliqueness'
  NSExpansionAttributeName = 'NSExpansion'
  NSCursorAttributeName = 'NSCursor'
  NSToolTipAttributeName = 'NSToolTip'
  NSMarkedClauseSegmentAttributeName = 'NSMarkedClauseSegment'
  NSWritingDirectionAttributeName = 'NSWritingDirection'
  NSTextAlternativesAttributeName = 'NSTextAlternatives'

  def dummy
    foo = NSFontAttributeName
    foo = NSParagraphStyleAttributeName
    foo = NSForegroundColorAttributeName
    foo = NSUnderlineStyleAttributeName
    foo = NSSuperscriptAttributeName
    foo = NSBackgroundColorAttributeName
    foo = NSAttachmentAttributeName
    foo = NSLigatureAttributeName
    foo = NSBaselineOffsetAttributeName
    foo = NSKernAttributeName
    foo = NSLinkAttributeName
    foo = NSStrokeWidthAttributeName
    foo = NSStrokeColorAttributeName
    foo = NSUnderlineColorAttributeName
    foo = NSStrikethroughStyleAttributeName
    foo = NSStrikethroughColorAttributeName
    foo = NSShadowAttributeName
    foo = NSObliquenessAttributeName
    foo = NSExpansionAttributeName
    foo = NSCursorAttributeName
    foo = NSToolTipAttributeName
    foo = NSMarkedClauseSegmentAttributeName
    foo = NSWritingDirectionAttributeName
    foo = NSVerticalGlyphFormAttributeName
    foo = NSTextAlternativesAttributeName
    foo = NSLeftTextAlignment
    foo = NSRightTextAlignment
    foo = NSCenterTextAlignment
    foo = NSJustifiedTextAlignment
    foo = NSNaturalTextAlignment
  end

  def to_s
    string
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

  # @param font [UIFont] Optional, defaults to UIFont.systemFontOfSize(UIFont.systemFontSize)
  # @return [UILabel]
  def uilabel
    UILabel.alloc.initWithFrame([[0, 0], [0, 0]]).tap { |label|
      label.attributedText = self
      label.backgroundColor = :clear.uicolor
      label.sizeToFit
    }
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

  def superscript(value)
    with_attributes({NSSuperscriptAttributeName => value})
  end

  def background_color(value)
    with_attributes({NSBackgroundColorAttributeName => value.uicolor})
  end
  alias bg_color background_color

  def attachment(value)
    with_attributes({NSAttachmentAttributeName => value})
  end

  def ligature(value)
    with_attributes({NSLigatureAttributeName => value})
  end

  def baseline_offset(value)
    with_attributes({NSBaselineOffsetAttributeName => value})
  end

  def kern(value)
    with_attributes({NSKernAttributeName => value})
  end

  def link(value)
    with_attributes({NSLinkAttributeName => value})
  end

  def stroke_width(value)
    with_attributes({NSStrokeWidthAttributeName => value})
  end

  def stroke_color(value)
    with_attributes({NSStrokeColorAttributeName => value.uicolor})
  end

  def underline_color(value)
    with_attributes({NSUnderlineColorAttributeName => value.uicolor})
  end

  def strikethrough_style(value)
    with_attributes({NSStrikethroughStyleAttributeName => value})
  end

  def strikethrough_color(value)
    with_attributes({NSStrikethroughColorAttributeName => value.uicolor})
  end

  def shadow(value)
    with_attributes({NSShadowAttributeName => value})
  end

  def obliqueness(value)
    with_attributes({NSObliquenessAttributeName => value})
  end

  def expansion(value)
    with_attributes({NSExpansionAttributeName => value})
  end

  def cursor(value)
    with_attributes({NSCursorAttributeName => value})
  end

  def tool_tip(value)
    with_attributes({NSToolTipAttributeName => value})
  end

  def marked_clause_segment(value)
    with_attributes({NSMarkedClauseSegmentAttributeName => value})
  end

  def writing_direction(value)
    with_attributes({NSWritingDirectionAttributeName => value})
  end

  def vertical_glyph_form(value)
    with_attributes({NSVerticalGlyphFormAttributeName => value})
  end

  def text_alternatives(value)
    with_attributes({NSTextAlternativesAttributeName => value})
  end

  def with_attributes(attributes)
    retval = NSMutableAttributedString.alloc.initWithAttributedString(self)
    retval.addAttributes(attributes, range:[0, self.length])
    retval
  end

  def nsattributedstring
    self
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
