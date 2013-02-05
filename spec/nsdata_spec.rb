describe "NSData" do

  it "should be able to create a string from data" do
    "test".nsdata.nsstring.should == "test"
  end

  it "should be able to create a unicode string from data" do
    "t\u0113st".nsdata.nsstring.should == "t\u0113st"
  end

end
