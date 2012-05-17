class String

  def uiimage
    UIImage.imageNamed(self)
  end

  def uifont(size=UIFont.systemFontSize)
    UIFont.fontWithName(self, size:size)
  end

end
