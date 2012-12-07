class NSString

  def nsurl
    @url ||= NSURL.alloc.initWithString(self)
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

  def uiimage
    UIImage.imageNamed(self)
  end

  def uiimageview
    self.uiimage ? self.uiimage.uiimageview : UIImageView.alloc.initWithImage(nil)
  end

  def uifont(size=UIFont.systemFontSize)
    UIFont.fontWithName(self, size:size)
  end

  def uicolor(alpha=nil)
    if self[0,1] == '#'
      if self.length == 4
        return (self[1] * 2 + self[2] * 2 + self[3] * 2).to_i(16).uicolor(alpha)
      end
      return self[1..-1].to_i(16).uicolor(alpha)
    end

    self.uiimage.uicolor(alpha)
  end

  # This can be called as `"Hello".localized` or `"Hello"._`.  The `str._`
  # syntax is meant to be reminiscent of gettext-style `_(str)`.
  def localized(value=nil, table=nil)
    @localized = NSBundle.mainBundle.localizedStringForKey(self, value:value, table:table)
  end
  alias _ localized

  # @param bundle [NSBundle] A bundle to search in.  Default is `nil`, which
  #   will use NSBundle.mainBundle
  def uinib(bundle=nil)
    UINib.nibWithNibName(self, bundle:bundle)
  end

end
