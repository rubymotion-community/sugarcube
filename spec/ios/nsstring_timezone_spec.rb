describe "NSString to NSTimeZone" do

  it "should parse timezone as UTC" do
    "UTC".nstimezone.secondsFromGMT.should == 0
  end

  it "should parse timezone as Asia/Tokyo" do
    "Asia/Tokyo".nstimezone.secondsFromGMT.should == 9 * 60 * 60
  end

  it "should parse timezone as Asia/Tokyo" do
    "UTC+9".nstimezone.secondsFromGMT.should == 9 * 60 * 60
  end

  it "should parse timezone as Asia/Tokyo" do
    "GMT+9".nstimezone.secondsFromGMT.should == 9 * 60 * 60
  end

  it "should parse timezone as Asia/Tokyo" do
    "+0900".nstimezone.secondsFromGMT.should == 9 * 60 * 60
  end

  it "should parse timezone integer as Asia/Tokyo" do
    (9 * 60 * 60).nstimezone.secondsFromGMT.should == 9 * 60 * 60
  end

end
