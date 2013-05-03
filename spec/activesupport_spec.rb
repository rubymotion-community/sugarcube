class LifeUniverseAndEverything
  def include?(obj)
    obj == 42
  end
end


describe 'ActiveSupport' do

  describe "should have a blank? method" do
    it "should be false for #{true.inspect}" do
      true.blank?.should == false
    end
    it "should be false for #{false.inspect}" do
      false.blank?.should == true
    end
    it "should be false for #{[].inspect}" do
      [].blank?.should == true
    end
    it "should be false for #{[1].inspect}" do
      [1].blank?.should == false
    end
    it "should be false for #{{}.inspect}" do
      {}.blank?.should == true
    end
    it "should be false for #{{a:1}.inspect}" do
      {a:1}.blank?.should == false
    end
    it "should be false for #{''.inspect}" do
      ''.blank?.should == true
    end
    it "should be false for #{'a'.inspect}" do
      'a'.blank?.should == false
    end
    it "should be false for #{' '.inspect}" do
      ' '.blank?.should == false
    end
  end

  describe "should have a present? method" do
    it "should be false for #{true.inspect}" do
      true.present?.should == true
    end
    it "should be false for #{false.inspect}" do
      false.present?.should == false
    end
    it "should be false for #{[].inspect}" do
      [].present?.should == false
    end
    it "should be false for #{[1].inspect}" do
      [1].present?.should == true
    end
    it "should be false for #{{}.inspect}" do
      {}.present?.should == false
    end
    it "should be false for #{{a:1}.inspect}" do
      {a:1}.present?.should == true
    end
    it "should be false for #{''.inspect}" do
      ''.present?.should == false
    end
    it "should be false for #{'a'.inspect}" do
      'a'.present?.should == true
    end
    it "should be false for #{' '.inspect}" do
      ' '.present?.should == true
    end
  end

  describe "in?" do
    it "should support arrays" do
      1.in?([1,2,3]).should == true
      0.in?([1,2,3]).should == false
    end

    it "should support hashes" do
      :a.in?({a:1,b:2,c:3}).should == true
      1.in?({a:1,b:2,c:3}).should == false
    end

    it "should support ranges" do
      1.in?(1..3).should == true
      0.in?(1..3).should == false
    end

    it "should support strings" do
      'a'.in?("apple").should == true
    end

    it "should support anything that implements `include?`" do
      42.in?(LifeUniverseAndEverything.new).should == true
      0.in?(LifeUniverseAndEverything.new).should == false
    end
  end

end
