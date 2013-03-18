class UILabel
	
  # forces the given text to fit inside the label's frame starting at a given font size 
  def fit_to_size(max_size)
    #enforce word wrap
    self.lineBreakMode = UILineBreakModeWordWrap
    
    dynamic_font = self.font.fontWithSize(max_size + 2)
    constraintSize = CGSizeMake(self.frame.size.width, 10000)

    # does it fit yet?
    begin
      dynamic_font = dynamic_font.fontWithSize(dynamic_font.pointSize - 2)
      current_size = self.text.sizeWithFont(dynamic_font, constrainedToSize:constraintSize, lineBreakMode:UILineBreakModeWordWrap)
    end while self.frame.size.height <= current_size.height

    #now set to font size we have settled on
    self.font = dynamic_font

  end

end