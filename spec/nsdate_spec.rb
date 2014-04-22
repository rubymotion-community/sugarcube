describe "NSDate" do

  it "Should have an NSDate##from_components method" do
    date = NSDate.from_components(year: 2012, month: 1, day: 2)
    date.year.should == 2012
    date.month.should == 1
    date.day.should == 2
  end

  it "Should have an NSDate##now method" do
    now = NSDate.new
    date = NSDate.now
    date.year.should == now.year
    date.month.should == now.month
    date.day.should == now.day
    date.hour.should == now.hour
    date.min.should == now.min
    (date.sec - now.sec).should <= 1
  end

  it "Should have an NSDate##today method" do
    now = NSDate.new
    date = NSDate.today
    date.year.should == now.year
    date.month.should == now.month
    date.day.should == now.day
    date.hour.should == 0
    date.min.should == 0
    date.sec.should == 0
  end

  it "NSDate##today method should be equal to itself" do
    date1 = NSDate.today
    date2 = NSDate.today
    date1.should == date2
  end

  it "Should have an NSDate##yesterday method" do
    now = NSDate.today
    date = NSDate.yesterday
    date.hour.should == 0
    date.min.should == 0
    date.sec.should == 0
    (now - date).in_hours.should >= 23  # keep in mind daylight
    (now - date).in_hours.should <= 25  # savings time.
  end

  it "NSDate##yesterday method should be equal to itself" do
    date1 = NSDate.yesterday
    date2 = NSDate.yesterday
    date1.should == date2
  end

  it "Should have an NSDate##tomorrow method" do
    now = NSDate.today
    date = NSDate.tomorrow
    date.hour.should == 0
    date.min.should == 0
    date.sec.should == 0
    (date - now).in_hours.should >= 23  # keep in mind daylight
    (date - now).in_hours.should <= 25  # savings time.
  end

  it "NSDate##tomorrow method should be equal to itself" do
    date1 = NSDate.tomorrow
    date2 = NSDate.tomorrow
    date1.should == date2
  end

  before do
    @date = NSDate.from_components(year: 2013, month: 1, day: 2, hour:12, minute: 15, second: 30)
  end

  it "should have an NSDate#string_with_style(date_style, time_style) method that accepts symbols" do
    @date.string_with_style(:medium).should == 'Jan 2, 2013'
    @date.string_with_style(:medium, :none).should == 'Jan 2, 2013'
    @date.string_with_style(:short, :medium).should == '1/2/13, 12:15:30 PM'
    @date.string_with_style(:none, :short).should == '12:15 PM'
  end

  it "should have an NSDate#string_with_style(date_style, time_style) method that has default" do
    @date.string_with_style.should == 'Jan 2, 2013'
  end

  it "should have an NSDate#string_with_style(date_style, time_style) method that accepts NSDateStyle constants" do
    @date.string_with_style(NSDateFormatterMediumStyle).should == 'Jan 2, 2013'
    @date.string_with_style(NSDateFormatterMediumStyle, NSDateFormatterNoStyle).should == 'Jan 2, 2013'
    @date.string_with_style(NSDateFormatterShortStyle, NSDateFormatterMediumStyle).should == '1/2/13, 12:15:30 PM'
    @date.string_with_style(NSDateFormatterNoStyle, NSDateFormatterShortStyle).should == '12:15 PM'
  end

  it "should have an NSDate#string_with_format method (1)" do
    @date.string_with_format("yyyyMMdd HH:mm:ss").should == '01/02/2013, 12:15:30'
  end

  it "should have an NSDate#string_with_format method (2)" do
    @date.string_with_format("yyyyMMMMd HH:mm:ss").should == 'January 2, 2013, 12:15:30'
  end

  it "should have an NSDate#string_with_format method (:iso8601)" do
    @date.string_with_format(:iso8601).should == '2013-01-02 12:15:30.000'
  end

  it "should have an NSDate#string_with_format method (:iso8601) and timezone" do
    date = @date + @date.utc_offset
    date.string_with_format(:iso8601, timezone:"UTC".nstimezone).should == '2013-01-02 12:15:30.000'
  end

  it "should have an NSDate#string_with_format method (:ymd)" do
    @date.string_with_format(:ymd).should == '2013-01-02'
  end

  it "should have an NSDate#string_with_format method (:hms)" do
    @date.string_with_format(:hms).should == '12:15:30.000'
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

  it "should retain the zimeZone" do
    @date.start_of_day.utc_offset.should == @date.utc_offset
  end

  it "should respect the timezone" do
    @date.getutc.start_of_day.getutc.hour.should == 0
  end

  it "NSDate#start_of_day should be equal to itself" do
    @date.start_of_day.should == @date.start_of_day
  end

  it "should have an NSDate#end_of_day method" do
    @date.end_of_day.datetime_array.should == [2013, 1, 3, 0, 0, 0]
  end

  it "NSDate#end_of_day should be equal to itself" do
    @date.end_of_day.should == @date.end_of_day
  end

  it "should have an NSDate#start_of_week method" do
    @date.start_of_week(:sunday).datetime_array.should == [2012, 12, 30, 0, 0, 0]
  end

  it "should have an NSDate#end_of_week method" do
    @date.end_of_week(:sunday).datetime_array.should == [2013, 1, 6, 0, 0, 0]
  end

  it "should have an NSDate#start_of_month method" do
    @date.start_of_month.datetime_array.should == [2013, 1, 1, 0, 0, 0]
  end

  it "should have an NSDate#end_of_month method" do
    @date.end_of_month.datetime_array.should == [2013, 2, 1, 0, 0, 0]
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
