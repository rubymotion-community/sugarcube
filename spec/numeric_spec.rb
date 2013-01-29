describe "Numeric" do

  it "should have a #percent method" do
    0.percent.should == 0
    50.percent.should == 0.50
    100.percent.should == 1
    200.percent.should == 2.0
  end

  it "should have a #radian(s) method" do
    0.radians.should == 0
    1.radian.should == 1
    1.5.radians.should == 1.5
  end

  it "should have a #degree(s) method" do
    0.degrees.should == 0
    1.degree.should == Math::PI / 180
    180.degrees.should == Math::PI
    45.degrees.should == Math::PI / 4
  end

  it "should have a #pi method" do
    0.pi.should == 0
    1.pi.should == Math::PI
    2.pi.should == Math::PI * 2
  end

  it "should have a #meter(s) method" do
    0.meters.should == 0
    1.meter.should == 1
    2.meters.should == 2
  end

  it "should have an #in_meters method" do
    0.in_meters.should == 0
    1.in_meters.should == 1
    2.in_meters.should == 2
  end

  it "should have a #kilometer(s) method" do
    0.kilometers.should == 0
    1.kilometer.should == 1000.meters
    0.5.kilometers.should == 500.meters
  end

  it "should have an #in_kilometers method" do
    0.in_kilometers.should == 0
    1000.meters.in_kilometers.should == 1
    500.meters.in_kilometers.should == 0.5
  end

  it "should have a #mile(s) method" do
    0.miles.should == 0.meters
    1.mile.round.should == 1609.meters
    2.miles.round.should == 3219.meters
  end

  it "should have an #in_miles method" do
    0.meters.in_miles.should == 0
    1609.meters.in_miles.round.should == 1
    3219.meters.in_miles.round.should == 2
  end

  it "should have a #feet(foot) method" do
    0.feet.should == 0
    3.foot.round.should == 1
    7.feet.round.should == 2
  end

  it "should have an #in_feet method" do
    0.meters.in_feet.should == 0
    1.meters.in_feet.round.should == 3
    2.meters.in_feet.round.should == 7
  end

  it "should have a #string_with_style method" do
    1000.string_with_style.should == NSNumberFormatter.localizedStringFromNumber(1000, numberStyle:NSNumberFormatterDecimalStyle)
    1000.string_with_style(:decimal).should == NSNumberFormatter.localizedStringFromNumber(1000, numberStyle:NSNumberFormatterDecimalStyle)
    1000.string_with_style(:currency).should == NSNumberFormatter.localizedStringFromNumber(1000, numberStyle:NSNumberFormatterCurrencyStyle)
  end

end
