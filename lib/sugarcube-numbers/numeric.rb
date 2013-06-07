class Numeric

  def string_with_style(style=NSNumberFormatterDecimalStyle)
    if style.respond_to?(:nsnumberstyle)
      style = style.nsnumberstyle
    end
    NSNumberFormatter.localizedStringFromNumber(self, numberStyle:style)
  end

  def percent
    self / 100.0
  end

end
