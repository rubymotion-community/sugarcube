describe "NSColor component methods" do
  before do
    @black = NSColor.blackColor
    @gray = NSColor.grayColor
    @white = NSColor.whiteColor
    @some_color = NSColor.colorWithRed(0.6, green: 0.4, blue: 0.5, alpha:1.0)
  end

  it "should return 1,1,1 for white" do
    @white.red.should == 1
    @white.green.should == 1
    @white.blue.should == 1
  end

  it "should return 0,0,0 for black" do
    @black.red.should == 0
    @black.green.should == 0
    @black.blue.should == 0
  end

  it "should return 0.5,0.5,0.5 for gray" do
    @gray.red.should == 0.5
    @gray.green.should == 0.5
    @gray.blue.should == 0.5
  end

  it "should return correct rgb for some_color" do
    @some_color.red.should == 0.6
    @some_color.green.should == 0.4
    @some_color.blue.should == 0.5
  end

end
