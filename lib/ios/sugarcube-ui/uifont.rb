class UIFont
  def uifont(font_size=nil)
    if font_size.nil?
      self
    else
      font_size = font_size.uifontsize if font_size.respond_to?(:uifontsize)
      self.fontWithSize(font_size)
    end
  end
end
