describe "Base Methods" do
  it "parses a relative natural language string, returning a date" do
    today = Time.now
    t = SugarCube::DateParser.parse_date("tomorrow at 7:30 PM")
    t.should.is_a Time
    t.hour.should == 19
    t.min.should == 30
    t.sec.should == 0
    (t.day - today.day).should == 1
  end
  
  it "parses a specific natural language string, returning a date" do
    t = SugarCube::DateParser.parse_date("6/18/13 at 7:30 AM")
    t.month.should == 6
    t.day.should == 18
    t.year.should == 2013
    t.hour.should == 7
    t.min.should == 30
  end
end

describe "String Extensions" do
  it "parses a date the same as the base method" do
    "tomorrow at 7:30 PM".to_date.should == SugarCube::DateParser.parse_date("tomorrow at 7:30 PM")
  end
end