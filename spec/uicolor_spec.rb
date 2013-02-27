describe 'UIColor' do

  it "should have a #uicolor method" do
    UIColor.redColor.uicolor.should == UIColor.redColor
  end

  it "should have a #uicolor(alpha) method" do
    UIColor.redColor.uicolor(0.5).alpha.should == 0.5
  end

  it "should have a #+(color) method" do
    new_color = UIColor.whiteColor + UIColor.blackColor
    new_color.red.should == 0.5
    new_color.green.should == 0.5
    new_color.blue.should == 0.5
  end

end
