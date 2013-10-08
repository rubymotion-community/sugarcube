describe "UIView" do

  it "should convert to a UIImage" do
    test = UIView.alloc.initWithFrame([[0, 0], [10, 10]])
    image = test.uiimage
    image.class.should == UIImage
    CGSizeEqualToSize(image.size, [10, 10]).should == true
    image.scale.should == UIScreen.mainScreen.scale
  end

  it "should convert a UIScrollView to a UIImage" do
    test = UIScrollView.alloc.initWithFrame([[0, 0], [10, 10]])
    test.contentSize = [20, 20]

    image = test.uiimage
    image.class.should == UIImage
    CGSizeEqualToSize(image.size, [10, 10]).should == true
    image.scale.should == UIScreen.mainScreen.scale

    image = test.uiimage(:all)
    image.class.should == UIImage
    CGSizeEqualToSize(image.size, [20, 20]).should == true
    image.scale.should == UIScreen.mainScreen.scale

    image = test.uiimage(true)
    image.class.should == UIImage
    CGSizeEqualToSize(image.size, [20, 20]).should == true
    image.scale.should == UIScreen.mainScreen.scale
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
  end

  it "should convert point" do
    view1 = UIView.alloc.initWithFrame([[0, 0], [100, 100]])
    view2 = UIView.alloc.initWithFrame([[10, 5], [80, 90]])
    view1 << view2
    view3 = UIView.alloc.initWithFrame([[10, 5], [60, 80]])
    view2 << view3
    point = view3.convert_origin(view1)
    point.x.should == 20
    point.y.should == 10
  end

  it "should return x" do
    view = UIView.alloc.initWithFrame([[100, 200], [300, 400]])
    view.x.should == view.frame.origin.x
  end

  it "should set x" do
    view = UIView.alloc.initWithFrame([[100, 200], [300, 400]])
    view.x = 500
    view.x.should == 500
  end

  it "should return y" do
    view = UIView.alloc.initWithFrame([[100, 200], [300, 400]])
    view.y.should == view.frame.origin.y
  end

  it "should set y" do
    view = UIView.alloc.initWithFrame([[100, 200], [300, 400]])
    view.y = 500
    view.y.should == 500
  end

  it "should return width" do
    view = UIView.alloc.initWithFrame([[100, 200], [300, 400]])
    view.width.should == view.frame.size.width
  end

  it "should set width" do
    view = UIView.alloc.initWithFrame([[100, 200], [300, 400]])
    view.width = 500
    view.width.should == 500
  end

  it "should return height" do
    view = UIView.alloc.initWithFrame([[100, 200], [300, 400]])
    view.height.should == view.frame.size.height
  end

  it "should set height" do
    view = UIView.alloc.initWithFrame([[100, 200], [300, 400]])
    view.height = 500
    view.height.should == 500
  end

end
