class NSString

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

  def underline
    underline_style(NSSingleUnderlineStyle)
  end

  def underline_style(value)
    with_attributes({NSUnderlineStyleAttributeName => value})
  end

  def superscript(amount=nil)
    amount ||= 1
    with_attributes({ NSSuperscriptAttributeName => amount })
  end

  def subscript
    superscript(-1)
  end

end
