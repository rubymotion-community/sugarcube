describe "UIView" do

  it "should convert to a UIImage" do
    test = UIView.alloc.initWithFrame([[0, 0], [10, 10]])
    image = test.uiimage
    image.class.should == UIImage
    CGSizeEqualToSize(image.size, [10, 10]).should == true
    image.scale.should == UIScreen.mainScreen.scale
  end

end
