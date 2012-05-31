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

end
