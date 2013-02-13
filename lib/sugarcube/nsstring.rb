class NSString

  # @return [NSURL]
  def nsurl
    @url ||= NSURL.alloc.initWithString(self)
  end

  # @return [NSData] NSData representation encoded using UTF8, or a specified
  #   encoding
  def nsdata(encoding=NSUTF8StringEncoding)
    dataUsingEncoding(encoding)
  end

  # @return [UIImage]
  def uiimage
    UIImage.imageNamed(self)
  end

  # @return [UIImageView]
  def uiimageview
    self.uiimage ? self.uiimage.uiimageview : UIImageView.alloc.initWithImage(nil)
  end

  # @return [UIFont]
  def uifont(size=nil)
    size ||= UIFont.systemFontSize
    UIFont.fontWithName(self, size:size)
  end

  # @return [UIColor]
  def uicolor(alpha=nil)
    if self[0,1] == '#'
      if self.length == 4
        return (self[1] * 2 + self[2] * 2 + self[3] * 2).to_i(16).uicolor(alpha)
      end
      return self[1..-1].to_i(16).uicolor(alpha)
    end

    self.uiimage.uicolor(alpha)
  end

  # @param font [UIFont] Optional, defaults to UIFont.systemFontOfSize(UIFont.systemFontSize)
  # @return [UILabel]
  def uilabel(font=nil)
    font ||= :system.uifont(:label.uifontsize)
    size = self.sizeWithFont(font)
    UILabel.alloc.initWithFrame([[0, 0], size]).tap { |label|
      label.text = self
      label.font = font
      # why isn't this just the default!?
      label.backgroundColor = :clear.uicolor
    }
  end

  def escape_url
    CFURLCreateStringByAddingPercentEscapes(
            nil,
            self,
            nil,
            "!*'();:@&=+$,/?%#[]",
            CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)
            )
  end

  def unescape_url
    CFURLCreateStringByReplacingPercentEscapes(
            nil,
            self,
            ""
            )
  end

  # This can be called as `"Hello".localized` or `"Hello"._`.  The `str._`
  # syntax is meant to be reminiscent of gettext-style `_(str)`.
  def localized(value=nil, table=nil)
    @localized = NSBundle.mainBundle.localizedStringForKey(self, value:value, table:table)
  end
  alias _ localized

end
