describe UIView do

  it "should convert to a UIImage" do
    test = UIView.alloc.initWithFrame([[0, 0], [10, 10]])
    test.backgroundColor = :black.uicolor

    red = UIView.alloc.initWithFrame([[0, 0], [2, 2]])
    red.backgroundColor = :red.uicolor
    test << red

    image = test.uiimage
    image.class.should == UIImage
    CGSizeEqualToSize(image.size, [10, 10]).should == true
    image.scale.should == UIScreen.mainScreen.scale
    # file = 'uiview_uiimage_test.png'.document
    # image.nsdata.write_to(file)
  end

  it "should convert a UIScrollView to a UIImage" do
    # scrollview has to be in the active window, or screen shot doesn't work
    # (doesn't apply to other views)
    window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    window.makeKeyAndVisible

    test = UIScrollView.alloc.initWithFrame([[0, 0], [10, 10]])
    test.contentSize = [20, 20]
    test.contentOffset = [2.5, 2.5]
    test.backgroundColor = :black.uicolor
    window << test

    red = UIView.alloc.initWithFrame([[0, 0], [8, 8]])
    red.backgroundColor = :red.uicolor(0.5)
    test << red
    # file = 'uiview_uiimage_red.png'.document
    # red.uiimage.nsdata.write_to(file)

    green = UIView.alloc.initWithFrame([[10, 0], [10, 10]])
    green.backgroundColor = :green.uicolor(0.5)
    test << green
    # file = 'uiview_uiimage_green.png'.document
    # green.uiimage.nsdata.write_to(file)

    blue = UIView.alloc.initWithFrame([[0, 10], [10, 10]])
    blue.backgroundColor = :blue.uicolor(0.5)
    test << blue
    # file = 'uiview_uiimage_blue.png'.document
    # blue.uiimage.nsdata.write_to(file)

    white = UIView.alloc.initWithFrame([[10, 10], [10, 10]])
    white.backgroundColor = :white.uicolor(0.5)
    test << white
    # file = 'uiview_uiimage_white.png'.document
    # white.uiimage.nsdata.write_to(file)

    gray = UIView.alloc.initWithFrame([[18, 18], [2, 2]])
    gray.backgroundColor = :gray.uicolor(0.5)
    test << gray

    image = test.uiimage
    image.class.should == UIImage
    CGSizeEqualToSize(image.size, [10, 10]).should == true
    image.scale.should == UIScreen.mainScreen.scale
    # file = 'uiview_uiimage_small.png'.document
    # image.nsdata.write_to(file)

    image = test.uiimage(:all)
    image.class.should == UIImage
    CGSizeEqualToSize(image.size, [20, 20]).should == true
    image.scale.should == UIScreen.mainScreen.scale

    image = test.uiimage(true)
    image.class.should == UIImage
    CGSizeEqualToSize(image.size, [20, 20]).should == true
    image.scale.should == UIScreen.mainScreen.scale
    # file = 'uiview_uiimage_big.png'.document
    # image.nsdata.write_to(file)
  end

  describe "should convert bounds" do
    before do
      @view1 = UIView.alloc.initWithFrame([[0, 0], [100, 100]])
      @view2 = UIView.alloc.initWithFrame([[10, 5], [80, 90]])
      @view1 << @view2
      @view3 = UIView.alloc.initWithFrame([[10, 5], [60, 80]])
      @view2 << @view3
    end

    it "should convert_frame_to" do
      frame = @view3.convert_frame_to(@view1)
      frame.origin.x.should == 20
      frame.origin.y.should == 10
      frame.size.width.should == 60
      frame.size.height.should == 80
    end

    it "should convert_frame_from" do
      frame = @view1.convert_frame_from(@view3)
      frame.origin.x.should == 20
      frame.origin.y.should == 10
      frame.size.width.should == 60
      frame.size.height.should == 80
    end

    it "should convert_rect(to:)" do
      frame = @view3.convert_rect([[1, 2], [10, 20]], to: @view1)
      frame.origin.x.should == 21
      frame.origin.y.should == 12
      frame.size.width.should == 10
      frame.size.height.should == 20
    end

    it "should convert_rect(from:)" do
      frame = @view1.convert_rect([[1, 2], [10, 20]], from: @view3)
      frame.origin.x.should == 21
      frame.origin.y.should == 12
      frame.size.width.should == 10
      frame.size.height.should == 20
    end

  end

  describe "should convert point" do
    before do
      @view1 = UIView.alloc.initWithFrame([[0, 0], [100, 100]])
      @view2 = UIView.alloc.initWithFrame([[10, 5], [80, 90]])
      @view1 << @view2
      @view3 = UIView.alloc.initWithFrame([[10, 5], [60, 80]])
      @view2 << @view3
    end

    it "should convert_origin_to" do
      point = @view3.convert_origin_to(@view1)
      point.x.should == 20
      point.y.should == 10
    end

    it "should convert_origin_from" do
      point = @view1.convert_origin_from(@view3)
      point.x.should == 20
      point.y.should == 10
    end

    it "should convert_point(to:)" do
      point = @view3.convert_point([1, 2], to: @view1)
      point.x.should == 21
      point.y.should == 12
    end

    it "should convert_point(:from)" do
      point = @view1.convert_point([1, 2], from: @view3)
      point.x.should == 21
      point.y.should == 12
    end

  end

end
