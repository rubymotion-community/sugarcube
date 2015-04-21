describe NSColor do

  it "should support #nscolor" do
    NSColor.redColor.nscolor.should == NSColor.redColor
  end

  it "should support #nscolor(alpha) method" do
    NSColor.redColor.nscolor(0.5).alpha.should == 0.5
  end

  it "should support #cgcolor" do
    -> do
      NSColor.redColor.cgcolor.should == NSColor.redColor.CGColor
    end.should.not.raise
  end

  it "should support #skcolor" do
    NSColor.redColor.skcolor.should == NSColor.redColor
  end

  it "should have a #skcolor(alpha) method" do
    NSColor.redColor.skcolor(0.5).alpha.should == 0.5
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
    NSColor.redColor.invert.should == NSColor.cyanColor
    NSColor.greenColor.invert.should == NSColor.magentaColor
    NSColor.blueColor.invert.should == NSColor.yellowColor

    NSColor.whiteColor.invert.red.should == 0
    NSColor.whiteColor.invert.green.should == 0
    NSColor.whiteColor.invert.blue.should == 0

    NSColor.blackColor.invert.red.should == 1
    NSColor.blackColor.invert.green.should == 1
    NSColor.blackColor.invert.blue.should == 1
  end

  it "should have a #mix_with method" do
    white = NSColor.whiteColor
    black = NSColor.blackColor
    gray = NSColor.grayColor
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

  it "should process system colors with a NSNamedColorSpace correctly" do
    NSColor.controlTextColor.invert.should.not.raise(StandardError)
  end

end


describe 'Fixnum NSColor extensions' do
  it "should support #nscolor" do
    color = 0xffffff.nscolor
    color.red.should == 1
    color.green.should == 1
    color.blue.should == 1
    color.alpha.should == 1
  end

  it "should support #cgcolor" do
    -> do
      0xffffff.cgcolor.class.should == NSColor.redColor.CGColor.class
    end.should.not.raise
  end

  it "should support #skcolor" do
    0xffffff.skcolor.should.be.kind_of(NSColor)
  end

  it "should have a 0x000000#nscolor(0.5) method" do
    color = 0.nscolor(0.5)
    color.red.should == 0
    color.green.should == 0
    color.blue.should == 0
    color.alpha.should == 0.5
  end
end


describe 'NSArray NSColor extensions' do
  it "should support #nscolor" do
    color = [255, 255, 255].nscolor
    color.red.should == 1
    color.green.should == 1
    color.blue.should == 1
    color.alpha.should == 1
  end

  it "should support #cgcolor" do
    -> do
      [255, 255, 255].cgcolor.class.should == NSColor.redColor.CGColor.class
    end.should.not.raise
  end

  it "should support #skcolor" do
    [255, 255, 255].skcolor.should.be.kind_of(NSColor)
  end

  it "should have a [0, 0, 0]#nscolor(0.5) method" do
    color = [0, 0, 0].nscolor(0.5)
    color.red.should == 0
    color.green.should == 0
    color.blue.should == 0
    color.alpha.should == 0.5
  end
end


describe 'NSString NSColor extensions' do

  it "should support #nscolor" do
    color = '#ffffff'.nscolor
    color.should.be.kind_of(NSColor)
    color.red.should == 1.0
    color.green.should == 1.0
    color.blue.should == 1.0

    color = '#808080'.nscolor
    color.should.be.kind_of(NSColor)
    ((color.red * 2).round / 2.0).should == 0.5
    ((color.green * 2).round / 2.0).should == 0.5
    ((color.blue * 2).round / 2.0).should == 0.5
  end

  it "should support #cgcolor" do
    -> do
      '#ffffff'.cgcolor.class.should == NSColor.redColor.CGColor.class
    end.should.not.raise
  end

  it "should support #skcolor" do
    '#ffffff'.skcolor.should.be.kind_of(NSColor)
  end

  it "should have '#000000'.nscolor(0.5) method" do
    color = '#000000'.nscolor(0.5)
    color.should.be.kind_of(NSColor)
    color.red.should == 0
    color.green.should == 0
    color.blue.should == 0
    color.alpha.should == 0.5
  end

  it "that supports image names" do
    a = 'little_square'.nscolor
    b = 'little_square'.nsimage.nscolor
    a.should.be.kind_of(NSColor)
    b.should.be.kind_of(NSColor)
  end

  it "that supports non-existant image names" do
    'this is not my beautiful house!'.nscolor.should == nil
  end

end


describe 'NSImage NSColor extensions' do
  it 'should support #nscolor' do
    color = NSImage.imageNamed('little_square').nscolor
    color.should.be.kind_of(NSColor)
  end

  it 'should support #cgcolor' do
    -> do
      NSImage.imageNamed('little_square').cgcolor.class.should == NSColor.redColor.CGColor.class
    end.should.not.raise
  end

  it "should support #skcolor" do
    NSImage.imageNamed('little_square').skcolor.should.be.kind_of(NSColor)
  end

  it 'should support #nscolor(0.5)' do
    -> do
      NSImage.imageNamed('little_square').nscolor(0.5)
      # unfortunately, this doesn't work:
      # image.alpha.should == 0.5  # alpha returns 0 because this is not an RGB or HSB color
    end.should.not.raise
  end
end
