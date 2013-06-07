class NSString

  # @return boolean
  def nan?
    self.to_number.nil?
  end

  def to_number
    number_formatter = NSNumberFormatter.new
    number_formatter.numberFromString(self)
  end

end
