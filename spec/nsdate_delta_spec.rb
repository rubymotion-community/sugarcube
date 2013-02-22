describe "NSDate#delta" do

  it "should be pretty easy to add hours" do
    feb_28_2012 = NSDate.from_components(year:2012, month: 2, day: 28, hour: 17)
    feb_28_2012.delta(hours:1).should == NSDate.from_components(year:2012, month: 2, day: 28, hour: 18)
  end

  it "should be pretty easy to add minutes" do
    feb_28_2012 = NSDate.from_components(year:2012, month: 2, day: 28, hour: 17, minute:10)
    feb_28_2012.delta(minutes:10).should == NSDate.from_components(year:2012, month: 2, day: 28, hour: 17, minute:20)
  end

  it "should be easy to add minutes that change the hour" do
    feb_28_2012 = NSDate.from_components(year:2012, month: 2, day: 28, hour: 17, minute:55)
    feb_28_2012.delta(minutes:10).should == NSDate.from_components(year:2012, month: 2, day: 28, hour: 18, minute:5)
  end

  it "should be easy to add minutes that change the day" do
    feb_28_2012 = NSDate.from_components(year:2012, month: 2, day: 28, hour: 23, minute:55)
    feb_28_2012.delta(minutes:10).should == NSDate.from_components(year:2012, month: 2, day: 29, hour: 0, minute:5)
  end

  it "should be pretty easy to add seconds" do
    feb_28_2012 = NSDate.from_components(year:2012, month: 2, day: 28, hour: 17, second:10)
    feb_28_2012.delta(seconds:10).should == NSDate.from_components(year:2012, month: 2, day: 28, hour: 17, second:20)
  end

  it "should be easy to add seconds that change the hour" do
    feb_28_2012 = NSDate.from_components(year:2012, month: 2, day: 28, hour: 17, second:55)
    feb_28_2012.delta(seconds:10).should == NSDate.from_components(year:2012, month: 2, day: 28, hour: 17, minute:1, second:5)
  end

  it "should be easy to add seconds that change the day" do
    feb_28_2012 = NSDate.from_components(year:2012, month: 2, day: 28, hour: 23, minute:59, second:55)
    feb_28_2012.delta(seconds:10).should == NSDate.from_components(year:2012, month: 2, day: 29, hour: 0, minute:0, second:5)
  end

  it "should be easy to add a day" do
    feb_28_2012 = NSDate.from_components(year:2012, month: 2, day: 28)
    feb_28_2012.delta(days:1).should == NSDate.from_components(year:2012, month: 2, day: 29)
  end

  it "should be easy to add two days" do
    feb_28_2012 = NSDate.from_components(year:2012, month: 2, day: 28)
    feb_28_2012.delta(days:2).should == NSDate.from_components(year:2012, month: 3, day: 1)
  end

  it "should be easy to add a month" do
    feb_28_2012 = NSDate.from_components(year:2012, month: 2, day: 28)
    feb_28_2012.delta(months:1).should == NSDate.from_components(year:2012, month: 3, day: 28)
  end

  it "should be easy to add a month and a day" do
    feb_28_2012 = NSDate.from_components(year:2012, month: 2, day: 28)
    feb_28_2012.delta(months:1, days:1).should == NSDate.from_components(year:2012, month: 3, day: 29)
  end

  it "should be easy to add two months" do
    feb_28_2012 = NSDate.from_components(year:2012, month: 2, day: 28)
    feb_28_2012.delta(months:2).should == NSDate.from_components(year:2012, month: 4, day: 28)
  end

  it "should be easy to add 11 months" do
    feb_28_2012 = NSDate.from_components(year:2012, month: 2, day: 28)
    feb_28_2012.delta(months:11).should == NSDate.from_components(year:2013, month: 1, day: 28)
  end

  it "should be easy to add 11 months and 3 days" do
    feb_28_2012 = NSDate.from_components(year:2012, month: 2, day: 28)
    feb_28_2012.delta(months:11, days:3).should == NSDate.from_components(year:2013, month: 1, day: 31)
  end

  it "should be easy to add a year" do
    feb_28_2012 = NSDate.from_components(year:2012, month: 2, day: 28)
    feb_28_2012.delta(years:1).should == NSDate.from_components(year:2013, month: 2, day: 28)
  end

  it "should be easy to add a year and a day" do
    feb_28_2012 = NSDate.from_components(year:2012, month: 2, day: 28)
    feb_28_2012.delta(years:1, days:1).should == NSDate.from_components(year:2013, month: 3, day: 1)
  end

  it "should be easy to add four years" do
    feb_28_2012 = NSDate.from_components(year:2012, month: 2, day: 28)
    feb_28_2012.delta(years:4).should == NSDate.from_components(year:2016, month: 2, day: 28)
  end

  it "should handle daylight savings logically" do
    # early hours
    mar_9_2012 = NSDate.from_components(year:2013, month: 3, day: 9, hour: 1)
    mar_9_2012.delta(days:1).should == NSDate.from_components(year:2013, month: 3, day: 10, hour: 1)

    # late hours
    mar_9_2012 = NSDate.from_components(year:2013, month: 3, day: 9, hour: 13)
    mar_9_2012.delta(days:1).should == NSDate.from_components(year:2013, month: 3, day: 10, hour: 13)
  end

  it "should handle daylight savings logically unless you assign an hour" do
    mar_9_2012 = NSDate.from_components(year:2013, month: 3, day: 9, hour: 13)
    mar_9_2012.delta(days:1, hours: 1).should == NSDate.from_components(year:2013, month: 3, day: 10, hour: 15)
  end

end
