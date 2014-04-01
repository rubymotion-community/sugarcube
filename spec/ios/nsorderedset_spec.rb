describe "NSOrderedSet" do

  # NSOrderedSet keesp ordering
  it "should have a method #to_a" do
    [1,0].nsorderedset.to_a.should == [1,0]
  end
  
  # NSSet doesn't keep ordering. It's sorted.
  it "should have a method #to_a" do
    [1,0].nsset.to_a.should == [0,1]
  end
  
end
