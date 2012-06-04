class String

  def uiimage
    UIImage.imageNamed(self)
  end

  def uifont(size=UIFont.systemFontSize)
    UIFont.fontWithName(self, size:size)
  end

  def uicolor
    if self[0,1] == '#'
      return self[1..-1].to_i(16).uicolor
    end

    begin
      self.to_sym.uicolor
    rescue SugarNotFoundException
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
