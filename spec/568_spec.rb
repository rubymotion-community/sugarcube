describe "568" do
  it "should load 568h images" do
    image = 'tall'.uiimage
    image.size.height.should == UIScreen.mainScreen.bounds.size.height
  end
end
