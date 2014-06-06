describe 'NSColor' do

  it "should support #nscolor" do
    NSColor.redColor.nscolor.should == NSColor.redColor
  end

  it "should support #cgcolor" do
    -> do
      NSColor.redColor.cgcolor.should == NSColor.redColor.CGColor
    end.should.not.raise
  end

  it "should support #skcolor" do
    NSColor.redColor.skcolor.should == NSColor.redColor
  end

  it "should support #nscolor(alpha) method" do
    NSColor.redColor.nscolor(0.5).alpha.should == 0.5
  end

  describe "should have a #+(color) method" do

    it 'should add white and black to make gray' do
      new_color = NSColor.whiteColor + NSColor.blackColor
      new_color.red.should == 0.5
      new_color.green.should == 0.5
      new_color.blue.should == 0.5
      new_color.alpha.should == 1.0
    end

    it 'should add black and white to make gray' do
      new_color = NSColor.blackColor + NSColor.whiteColor
      new_color.red.should == 0.5
      new_color.green.should == 0.5
      new_color.blue.should == 0.5
      new_color.alpha.should == 1.0
    end

    it 'should add alpha channel (white + clear)' do
      new_color = NSColor.whiteColor + NSColor.clearColor
      new_color.red.should == 1.0
      new_color.green.should == 1.0
      new_color.blue.should == 1.0
      new_color.alpha.should == 0.5
    end

    it 'should add alpha channel (clear + white)' do
      new_color = NSColor.clearColor + NSColor.whiteColor
      new_color.red.should == 1.0
      new_color.green.should == 1.0
      new_color.blue.should == 1.0
      new_color.alpha.should == 0.5
    end

  end

  describe "should have a #<<(color) method" do
    it "should return white no matter what" do
      new_color = NSColor.whiteColor << NSColor.blackColor
      new_color.red.should == 1.0
      new_color.green.should == 1.0
      new_color.blue.should == 1.0
    end

    it "should have no effect with black" do
      new_color = NSColor.blueColor << NSColor.blackColor
      new_color.red.should == 0.0
      new_color.green.should == 0.0
      new_color.blue.should == 1.0
    end

    it "should add blue to red" do
      new_color = NSColor.redColor << NSColor.blueColor
      new_color.red.should == 1.0
      new_color.green.should == 0.0
      new_color.blue.should == 1.0
    end

    it "should use opacity when adding blue to red" do
      new_color = NSColor.redColor << NSColor.blueColor.colorWithAlphaComponent(0.5)
      new_color.red.should == 1.0
      new_color.green.should == 0.0
      new_color.blue.should == 0.5
    end

  end

  it "should have a #invert method" do
    :white.nscolor.invert.red.should == 0
    :white.nscolor.invert.green.should == 0
    :white.nscolor.invert.blue.should == 0

    :black.nscolor.invert.red.should == 1
    :black.nscolor.invert.green.should == 1
    :black.nscolor.invert.blue.should == 1
  end

  it "should have a #mix_with method" do
    white = :white.nscolor
    black = :black.nscolor
    gray = :gray.nscolor
    white.mix_with(black, 0).red.should == 1
    white.mix_with(black, 0).green.should == 1
    white.mix_with(black, 0).blue.should == 1

    white.mix_with(black, 1).red.should == 0
    white.mix_with(black, 1).green.should == 0
    white.mix_with(black, 1).blue.should == 0

    white.mix_with(black, 0.5).red.should == 0.5
    white.mix_with(black, 0.5).green.should == 0.5
    white.mix_with(black, 0.5).blue.should == 0.5

    white.mix_with(black, 0.25).red.should == 0.75
    white.mix_with(black, 0.25).green.should == 0.75
    white.mix_with(black, 0.25).blue.should == 0.75

    white.mix_with(black, 0.75).red.should == 0.25
    white.mix_with(black, 0.75).green.should == 0.25
    white.mix_with(black, 0.75).blue.should == 0.25
  end

end
