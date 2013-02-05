describe "Sanity" do

  it "should have Symbol#ivar" do
    :name.ivar.should == '@name'
  end

  it "should have String#ivar" do
    'another'.ivar.should == '@another'
  end

  it "should have Symbol#cvar" do
    :name.cvar.should == '@@name'
  end

  it "should have String#cvar" do
    'another'.cvar.should == '@@another'
  end

end
