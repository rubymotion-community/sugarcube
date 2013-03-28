describe "NSArray" do

  it "should have a method #to_pointer" do
    pointer = [1,2,3].to_pointer(:int)
    pointer.should != nil
    pointer[0].should == 1
    pointer[1].should == 2
    pointer[2].should == 3
  end

  it "should have a method #nsindexpath" do
    path = [0,1,2,3].nsindexpath
    path.length.should == 4
    path.indexAtPosition(0).should == 0
    path.indexAtPosition(1).should == 1
    path.indexAtPosition(2).should == 2
    path.indexAtPosition(3).should == 3
  end

  it "should have a method #nsindexset" do
    set = [0,1,2,3].nsindexset
    set.count.should == 4
    set.containsIndex(0).should == true
    set.containsIndex(1).should == true
    set.containsIndex(2).should == true
    set.containsIndex(3).should == true
    set.containsIndex(4).should == false
  end

  it "should have a [255,255,255]#uicolor method" do
    color = [255,255,255].uicolor
    color.red.should == 1
    color.green.should == 1
    color.blue.should == 1
    color.alpha.should == 1
  end

  it "should have a [0, 0, 0]#uicolor(0.5) method" do
    color = [0, 0, 0].uicolor(0.5)
    color.red.should == 0
    color.green.should == 0
    color.blue.should == 0
    color.alpha.should == 0.5
  end
  
  it "should have a method #nsset" do
    set = [0,1,0].nsset
    set.count.should == 2
  end

end
