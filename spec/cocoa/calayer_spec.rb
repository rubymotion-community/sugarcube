describe CALayer do

  it "should support <<" do
    layer = CALayer.layer
    another_layer = CALayer.layer
    layer << another_layer
    layer.sublayers.should == [another_layer]
  end

  it "should support unshift" do
    layer = CALayer.layer
    sub_layer1 = CALayer.layer
    sub_layer2 = CALayer.layer
    layer.unshift sub_layer1
    layer.unshift sub_layer2
    layer.sublayers.should == [sub_layer2, sub_layer1]
  end

end
