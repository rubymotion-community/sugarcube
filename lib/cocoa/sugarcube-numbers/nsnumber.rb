class NSNumber

  def string_with_style(style=NSNumberFormatterDecimalStyle)
    if style.respond_to?(:nsnumberstyle)
      style = style.nsnumberstyle
    end
    NSNumberFormatter.localizedStringFromNumber(self, numberStyle:style)
  end

end
