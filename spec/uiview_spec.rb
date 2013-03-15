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

end
