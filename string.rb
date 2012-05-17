

class String

  def uiimage
    return UIImage.imageNamed(self)
  end

  def uifont
    return UIFont.fontWithName(self, size:UIFont.systemFontSize)
  end

end
