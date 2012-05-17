

class UIFont

  #     "Inconsolata".uifont.size(30)
  # =>
  #     UIFont.fontWithName("Inconsolata", size: UIFont.systemFontSize).fontWithSize(30)
  def size(size)
    fontWithSize(size)
  end

end
