class NSString

  # @return boolean
  def nan?
    number_formatter = NSNumberFormatter.new
    number = number_formatter.numberFromString(self)
    number.nil?
  end

end
