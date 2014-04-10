describe CALayer do

  it "should support <<" do
    layer = CALayer.layer
    another_layer = CALayer.layer
    layer << another_layer
    layer.sublayers.should == [another_layer]
  end

end
