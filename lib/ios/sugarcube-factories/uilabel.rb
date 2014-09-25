class UILabel

  # UILabel.new('test')
  # UILabel.new('test', another_label.font)
  # UILabel.new('test', 'Helvetica')
  # UILabel.new('test', 'Helvetica', 20)
  def self.new(text=nil, font=nil, size=nil)
    return super() if text.nil?

    font = font.uifont(size) if font.respond_to?(:uifont)
    label = self.alloc.initWithFrame([[0, 0], [0, 0]])
    if text.is_a?(NSAttributedString)
      label.attributedText = text
    else
      label.text = text
    end
    if font
      label.font = font
    end
    label.backgroundColor = :clear.uicolor
    label.sizeToFit
    label
  end

end
