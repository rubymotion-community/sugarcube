class NSString

  def nsurl
    @url ||= NSURL.alloc.initWithString(self)
  end

  def uiimage
    @uiimage = UIImage.imageNamed(self)
  end

  def uiimageview
    @uiimageview ||= (self.uiimage and self.uiimage.uiimageview or UIImageView.alloc.initWithImage(nil))
  end

  def uifont(size=UIFont.systemFontSize)
    @uifont ||= {}
    @uifont[size] ||= UIFont.fontWithName(self, size:size)
  end

  def uicolor(alpha=nil)
    if self[0,1] == '#'
      # #fff
      if self.length == 4
        return (self[1] * 2 + self[2] * 2 + self[3] * 2).to_i(16).uicolor(alpha)
      end
      # else
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

end
