

class String

  def uiimage
    return UIImage.imageNamed(self)
  end

  def uifont(size=UIFont.systemFontSize)
    return UIFont.fontWithName(self, size:size)
  end

end
