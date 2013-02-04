describe "NSDate" do

  it "Should have an NSDate##from_components method" do
    date = NSDate.from_components(year: 2012, month: 1, day: 2)
    date.year.should == 2012
    date.month.should == 1
    date.day.should == 2
  end

  before do
    @date = NSDate.from_components(year: 2013, month: 1, day: 2, hour:12, minute: 15, second: 30)
  end

  it "should have an NSDate#string_with_style(style) method that accepts symbols" do
    @date.string_with_style(:medium).should == 'Jan 2, 2013'
  end

  it "should have an NSDate#string_with_style(style) method that accepts NSDateStyle constants" do
    @date.string_with_style(NSDateFormatterShortStyle).should == '1/2/13'
  end

  it "should have an NSDate#string_with_format method (1)" do
    @date.string_with_format("yyyyMMdd HH:mm:ss").should == '01/02/2013, 12:15:30'
  end

  it "should have an NSDate#string_with_format method (2)" do
    @date.string_with_format("yyyyMMMMd HH:mm:ss").should == 'January 2, 2013, 12:15:30'
  end

  it "should have an NSDate#timezone method" do
    String.should === @date.timezone.name
  end

  it "should have an NSDate#era method" do
    @date.era.should == 1
  end

  it "should have an NSDate#today method" do
    @date.today?.should == false
    NSDate.new.today?.should === true
  end

  it "should have an NSDate#same_day method" do
    @date.same_day?(@date.start_of_day).should === true
  end

  it "should have an NSDate#utc_offset method" do
    Fixnum.should === @date.utc_offset
  end

  it "should have an NSDate#leap_year method" do
    @date.leap_year?.should == false
    NSDate.from_components(year:2012, month:1, day:1).leap_year?.should == true
  end

  it "should have an NSDate#date_array method" do
    @date.date_array.should == [2013, 1, 2]
  end

  it "should have an NSDate#time_array method" do
    @date.time_array.should == [12, 15, 30]
  end

  it "should have an NSDate#datetime_array method" do
    @date.datetime_array.should == [2013, 1, 2, 12, 15, 30]
  end

  it "should have an NSDate#start_of_day method" do
    @date.start_of_day.datetime_array.should == [2013, 1, 2, 0, 0, 0]
  end

  it "should have an NSDate#end_of_day method" do
    @date.end_of_day.datetime_array.should == [2013, 1, 3, 0, 0, 0]
  end

  it "should have an NSDate#days_in_month method" do
    @date.days_in_month.should == 31
    NSDate.from_components(year:2013, month:2, day:1).days_in_month.should == 28
    NSDate.from_components(year:2012, month:2, day:1).days_in_month.should == 29
  end

  it "should have an NSDate#days_in_year method" do
    @date.days_in_year.should == 365
    NSDate.from_components(year:2013, month:2, day:1).days_in_year.should == 365
    NSDate.from_components(year:2012, month:2, day:1).days_in_year.should == 366
  end

end
