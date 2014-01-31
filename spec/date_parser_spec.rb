describe "Base Methods" do

  it "parses a relative natural language string, returning a date" do
    today = Time.now
    t = SugarCube::DateParser.parse_date("tomorrow at 7:30 PM")
    t.should.is_a Time
    t.hour.should == 19
    t.min.should == 30
    t.sec.should == 0

    if (today + 1.day).day == 1
      t.day.should == 1
    else
      (t.day - today.day).should == 1
    end
  end

  it "parses a specific natural language string, returning a date" do
    t = SugarCube::DateParser.parse_date("6/18/13 at 7:30 AM")
    t.month.should == 6
    t.day.should == 18
    t.year.should == 2013
    t.hour.should == 7
    t.min.should == 30
  end

  it "returns nil on failure" do
    t = SugarCube::DateParser.parse_date("NOT A DATE")
    t.should == nil
  end

  describe "parses iso8601 dates" do

    it "parses '2013-08-22T21:34:48.874Z'" do
      t = SugarCube::DateParser.parse_date("2013-08-22T21:34:48.874Z").getutc
      t.month.should == 8
      t.day.should == 22
      t.year.should == 2013
      t.min.should == 34
      t.sec.should == 48
      t.usec.should == 874000
    end

    it "parses '2013-08-22T21:34:48.874'" do
      t = SugarCube::DateParser.parse_date("2013-08-22T21:34:48.874").getutc
      t.month.should == 8
      t.day.should == 22
      t.year.should == 2013
      t.min.should == 34
      t.sec.should == 48
      t.usec.should == 874000
    end

    it "parses '2013-08-22T21:34:48Z'" do
      t = SugarCube::DateParser.parse_date("2013-08-22T21:34:48Z").getutc
      t.month.should == 8
      t.day.should == 22
      t.year.should == 2013
      t.min.should == 34
      t.sec.floor.should == 48
    end

    it "parses '2013-08-22T21:34:48'" do
      t = SugarCube::DateParser.parse_date("2013-08-22T21:34:48").getutc
      t.month.should == 8
      t.day.should == 22
      t.year.should == 2013
      t.min.should == 34
      t.sec.floor.should == 48
    end

  end

end

describe "String Extensions" do
  it "parses a date the same as the base method" do
    "tomorrow at 7:30 PM".to_date.should == SugarCube::DateParser.parse_date("tomorrow at 7:30 PM")
  end
end