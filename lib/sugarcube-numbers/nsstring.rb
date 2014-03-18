class NSString

  # @return boolean
  def nan?(style=NSNumberFormatterDecimalStyle)
    self.to_number(style).nil?
  end

  def to_number(style=NSNumberFormatterDecimalStyle)
    if style.respond_to?(:nsnumberstyle)
      style = style.nsnumberstyle
    end
    number_formatter = NSNumberFormatter.new
    number_formatter.numberStyle = style
    number_formatter.numberFromString(self)
  end

end
