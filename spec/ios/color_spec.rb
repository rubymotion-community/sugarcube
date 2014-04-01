describe UIColor do

  it "should have a #uicolor method" do
    UIColor.redColor.uicolor.should == UIColor.redColor
  end

  it "should have a #cgcolor method" do
    -> do
      UIColor.redColor.cgcolor.should == UIColor.redColor.CGColor
    end.should.not.raise
  end

  it "should have a #uicolor(alpha) method" do
    UIColor.redColor.uicolor(0.5).alpha.should == 0.5
  end

  describe "should have a #+(color) method" do

    it 'should add white and black to make gray' do
      new_color = UIColor.whiteColor + UIColor.blackColor
      new_color.red.should == 0.5
      new_color.green.should == 0.5
      new_color.blue.should == 0.5
      new_color.alpha.should == 1.0
    end

    it 'should add black and white to make gray' do
      new_color = UIColor.blackColor + UIColor.whiteColor
      new_color.red.should == 0.5
      new_color.green.should == 0.5
      new_color.blue.should == 0.5
      new_color.alpha.should == 1.0
    end

    it 'should add alpha channel (white + clear)' do
      new_color = UIColor.whiteColor + UIColor.clearColor
      new_color.red.should == 1.0
      new_color.green.should == 1.0
      new_color.blue.should == 1.0
      new_color.alpha.should == 0.5
    end

    it 'should add alpha channel (clear + white)' do
      new_color = UIColor.clearColor + UIColor.whiteColor
      new_color.red.should == 1.0
      new_color.green.should == 1.0
      new_color.blue.should == 1.0
      new_color.alpha.should == 0.5
    end

  end

  describe "should have a #<<(color) method" do
    it "should return white no matter what" do
      new_color = UIColor.whiteColor << UIColor.blackColor
      new_color.red.should == 1.0
      new_color.green.should == 1.0
      new_color.blue.should == 1.0
    end

    it "should have no effect with black" do
      new_color = UIColor.blueColor << UIColor.blackColor
      new_color.red.should == 0.0
      new_color.green.should == 0.0
      new_color.blue.should == 1.0
    end

    it "should add blue to red" do
      new_color = UIColor.redColor << UIColor.blueColor
      new_color.red.should == 1.0
      new_color.green.should == 0.0
      new_color.blue.should == 1.0
    end

    it "should use opacity when adding blue to red" do
      new_color = UIColor.redColor << UIColor.blueColor.colorWithAlphaComponent(0.5)
      new_color.red.should == 1.0
      new_color.green.should == 0.0
      new_color.blue.should == 0.5
    end

  end

  it "should have a #invert method" do
    UIColor.redColor.invert.should == UIColor.cyanColor
    UIColor.greenColor.invert.should == UIColor.magentaColor
    UIColor.blueColor.invert.should == UIColor.yellowColor

    UIColor.whiteColor.invert.red.should == 0
    UIColor.whiteColor.invert.green.should == 0
    UIColor.whiteColor.invert.blue.should == 0

    UIColor.blackColor.invert.red.should == 1
    UIColor.blackColor.invert.green.should == 1
    UIColor.blackColor.invert.blue.should == 1
  end

  it "should have a #mix_with method" do
    white = UIColor.whiteColor
    black = UIColor.blackColor
    gray = UIColor.grayColor
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


describe 'Fixnum UIColor extensions' do
  it "should have a 0xffffff#uicolor method" do
    color = 0xffffff.uicolor
    color.red.should == 1
    color.green.should == 1
    color.blue.should == 1
    color.alpha.should == 1
  end

  it "should have a 0xffffff#cgcolor method" do
    -> do
      0xffffff.cgcolor.should.not == nil
    end.should.not.raise
  end

  it "should have a 0x000000#uicolor(0.5) method" do
    color = 0.uicolor(0.5)
    color.red.should == 0
    color.green.should == 0
    color.blue.should == 0
    color.alpha.should == 0.5
  end
end


describe 'NSArray UIColor extensions' do
  it "should have a [255, 255, 255]#uicolor method" do
    color = [255, 255, 255].uicolor
    color.red.should == 1
    color.green.should == 1
    color.blue.should == 1
    color.alpha.should == 1
  end

  it "should have a [255, 255, 255]#cgcolor method" do
    -> do
      [255, 255, 255].cgcolor.should.not == nil
    end.should.not.raise
  end

  it "should have a [0, 0, 0]#uicolor(0.5) method" do
    color = [0, 0, 0].uicolor(0.5)
    color.red.should == 0
    color.green.should == 0
    color.blue.should == 0
    color.alpha.should == 0.5
  end
end


describe 'NSString UIColor extensions' do

  it "should have '#ffffff'.uicolor method" do
    color = '#ffffff'.uicolor
    color.should.be.kind_of(UIColor)
    color.red.should == 1.0
    color.green.should == 1.0
    color.blue.should == 1.0

    color = '#808080'.uicolor
    color.should.be.kind_of(UIColor)
    ((color.red * 2).round / 2.0).should == 0.5
    ((color.green * 2).round / 2.0).should == 0.5
    ((color.blue * 2).round / 2.0).should == 0.5
  end

  it "should have '#ffffff'.cgcolor method" do
    -> do
      '#ffffff'.cgcolor.should.not == nil
    end.should.not.raise
  end

  it "should have '#000000'.uicolor(0.5) method" do
    color = '#000000'.uicolor(0.5)
    color.should.be.kind_of(UIColor)
    color.red.should == 0
    color.green.should == 0
    color.blue.should == 0
    color.alpha.should == 0.5
  end

  it "that supports image names" do
    'little_square'.uicolor.should == 'little_square'.uiimage.uicolor
  end

  it "that supports non-existant image names" do
    'this is not my beautiful house!'.uicolor.should == nil
  end

end


describe 'UIImage UIColor extensions' do
  it 'should support #uicolor' do
    color = UIImage.imageNamed('little_square').uicolor
    color.should.be.kind_of(UIColor)
  end

  it 'should support #cgcolor' do
    -> do
      UIImage.imageNamed('little_square').cgcolor
    end.should.not.raise
  end

  it 'should support #uicolor(0.5)' do
    -> do
      UIImage.imageNamed('little_square').uicolor(0.5)
      # unfortunately, this doesn't work:
      # image.alpha.should == 0.5  # alpha returns 0 because this is not an RGB or HSB color
    end.should.not.raise
  end
end


