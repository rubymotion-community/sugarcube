class String

  def uiimage
    UIImage.imageNamed(self)
  end

  def uifont(size=UIFont.systemFontSize)
    UIFont.fontWithName(self, size:size)
  end

  def uicolor
    begin
      self.to_sym.uicolor
    rescue ColorNotFoundException
      self.uiimage.uicolor
    end
  end

  # This can be called as `"Hello".localized` or `"Hello"._`.  The `str._`
  # syntax is meant to be reminiscent of gettext-style `_(str)`.
  def localized(value=nil, table=nil)
    NSBundle.mainBundle.localizedStringForKey(self, value:value, table:table)
  end
  alias :_ :localized

end
