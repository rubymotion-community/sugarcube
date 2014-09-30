describe "Numeric" do

  it "should have a #percent method" do
    0.percent.should == 0
    50.percent.should == 0.50
    100.percent.should == 1
    200.percent.should == 2.0
  end

  it "should have a #g method" do
    0.g.should == 0
    1.g.should == 9.78033
  end

  it "should have an #in_g method" do
    0.in_g.should == 0
    9.78033.in_g.should == 1
  end

  it "should have a #radian(s) method" do
    0.radians.should == 0
    1.radian.should == 1
    1.5.radians.should == 1.5
  end

  it "should have a #in_radians method" do
    0.radians.in_radians.should == 0
    1.radian.in_radians.should == 1
    1.5.radians.in_radians.should == 1.5
  end

  it "should have a #degree(s) method" do
    0.degrees.should == 0
    1.degree.should == Math::PI / 180
    180.degrees.should == Math::PI
    45.degrees.should == Math::PI / 4
  end

  it "should have a #degree(s) method" do
    0.degrees.should == 0
    1.degree.in_degrees.round.should == 1
    180.degrees.in_degrees.round.should == 180
    45.degrees.in_degrees.round.should == 45
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

  it "should have a #byte method" do
    1.byte.should == 1
    2.bytes.should == 2
  end

  it "should have a #kilobyte method" do
    1.kilobyte.should == 1 * 1024**1
    2.kilobytes.should == 2 * 1024**1
  end

  it "should have a #megabyte method" do
    1.megabyte.should == 1 * 1024**2
    2.megabytes.should == 2 * 1024**2
  end

  it "should have a #gigabyte method" do
    1.gigabyte.should == 1 * 1024**3
    2.gigabytes.should == 2 * 1024**3
  end

  it "should have a #terabyte method" do
    1.terabyte.should == 1 * 1024**4
    2.terabytes.should == 2 * 1024**4
  end

  it "should have a #petabyte method" do
    1.petabyte.should == 1 * 1024**5
    2.petabytes.should == 2 * 1024**5
  end

  it "should have a #exabyte method" do
    1.exabyte.should == 1 * 1024**6
    2.exabytes.should == 2 * 1024**6
  end


  it "should have a #string_with_style method" do
    1000.string_with_style.should == NSNumberFormatter.localizedStringFromNumber(1000, numberStyle:NSNumberFormatterDecimalStyle)
    1000.string_with_style(:decimal).should == NSNumberFormatter.localizedStringFromNumber(1000, numberStyle:NSNumberFormatterDecimalStyle)
    1000.string_with_style(:currency).should == NSNumberFormatter.localizedStringFromNumber(1000, numberStyle:NSNumberFormatterCurrencyStyle)
  end

  it 'should have a #to_bool method' do
    0.to_bool.should == false
    1.to_bool.should == true
  end
end
