describe "Numeric" do

  it "should have a #string_with_style method" do
    1000.string_with_style.should == NSNumberFormatter.localizedStringFromNumber(1000, numberStyle:NSNumberFormatterDecimalStyle)
    1000.string_with_style(:decimal).should == NSNumberFormatter.localizedStringFromNumber(1000, numberStyle:NSNumberFormatterDecimalStyle)
    1000.string_with_style(:currency).should == NSNumberFormatter.localizedStringFromNumber(1000, numberStyle:NSNumberFormatterCurrencyStyle)
  end

end
