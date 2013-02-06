describe "NSData" do

  it "native methods should work - ASCII" do
    NSString.stringWithUTF8String('test'.dataUsingEncoding(NSUTF8StringEncoding)).should == 'test'
    NSString.stringWithUTF8String('test'.nsdata).should == 'test'
  end

  it "native methods should work - unicode" do
    NSString.stringWithUTF8String("t\u0113st".dataUsingEncoding(NSUTF8StringEncoding)).should == "t\u0113st"
    NSString.stringWithUTF8String("t\u0113st".nsdata).should == "t\u0113st"
  end

  it "native methods should work - turkey" do
    NSString.stringWithUTF8String("\u00ab\u03c4\u03b1\u0411\u042c\u2113\u03c3\u00bb".dataUsingEncoding(NSUTF8StringEncoding)).should == "\u00ab\u03c4\u03b1\u0411\u042c\u2113\u03c3\u00bb"
    NSString.stringWithUTF8String("\u00ab\u03c4\u03b1\u0411\u042c\u2113\u03c3\u00bb".nsdata).should == "\u00ab\u03c4\u03b1\u0411\u042c\u2113\u03c3\u00bb"
  end

  it "should be able to create an ASCII string from data" do
    'test'.nsdata.nsstring.should == 'test'
  end

  it "should be able to create a unicode string from data" do
    "t\u0113st".nsdata.nsstring.should == "t\u0113st"
  end

  it "should be able to create a turkey string from data" do
    "\u00ab\u03c4\u03b1\u0411\u042c\u2113\u03c3\u00bb".nsdata.nsstring.should == "\u00ab\u03c4\u03b1\u0411\u042c\u2113\u03c3\u00bb"
  end

end
