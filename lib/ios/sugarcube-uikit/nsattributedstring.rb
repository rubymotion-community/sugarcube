class NSAttributedString

  # @return [UILabel]
  def uilabel
    UILabel.alloc.initWithFrame([[0, 0], [0, 0]]).tap do |label|
      label.attributedText = self
      label.backgroundColor = :clear.uicolor
      label.sizeToFit
      label
    end
  end

end
