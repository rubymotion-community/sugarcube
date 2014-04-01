class ArbitraryCoercion
end


describe "Pipes" do

  describe "UIImage Pipes" do
    before do
      @image = 'little_square'.uiimage
    end

    it "should coerce into UIImage" do
      (@image | UIImage).should.be.kind_of(UIImage)
    end

    it "should coerce into UIView" do
      (@image | UIView).should.be.kind_of(UIView)
    end

    it "should coerce into UIImageView" do
      (@image | UIImageView).should.be.kind_of(UIImageView)
    end

    it "should coerce into CIImage" do
      (@image | CIImage).should.be.kind_of(CIImage)
    end

    it "should coerce into UIColor" do
      (@image | UIColor).should.be.kind_of(UIColor)
    end

    it "should coerce into NSData" do
      (@image | NSData).should.be.kind_of(NSData)
    end

    it "should not support arbitrary coercions" do
      ->{
        (@image | ArbitraryCoercion)
      }.should.raise
    end

    it "should apply CIFilter" do
      filter = CIFilter.gaussian_blur
      (@image | filter).should.be.kind_of(CIImage)
    end

    it "should apply multiple CIFilters" do
      filter1 = CIFilter.gaussian_blur(1)
      filter2 = CIFilter.gaussian_blur(2)
      (@image | filter1 | filter2).should.be.kind_of(CIImage)
    end

  end

  describe "UIView" do
    before do
      @view = UIView.alloc.initWithFrame([[0, 0], [1, 1]])
    end

    it "should coerce into UIImage" do
      (@view | UIImage).should.be.kind_of(UIImage)
    end

    it "should not support arbitrary coercions" do
      ->{
        (@view | ArbitraryCoercion)
      }.should.raise
    end

  end

  describe "CIImage" do
    before do
      @image = 'little_square'.uiimage.ciimage
    end

    it "should coerce into UIImage" do
      (@image | UIImage).should.be.kind_of(UIImage)
    end

    it "should coerce into UIView" do
      (@image | UIView).should.be.kind_of(UIView)
    end

    it "should coerce into UIImageView" do
      (@image | UIImageView).should.be.kind_of(UIImageView)
    end

    it "should coerce into CIImage" do
      (@image | CIImage).should.be.kind_of(CIImage)
    end

    it "should not support arbitrary coercions" do
      ->{
        (@image | ArbitraryCoercion)
      }.should.raise
    end

    it "should apply CIFilter" do
      filter = CIFilter.gaussian_blur
      (@image | filter).should.be.kind_of(CIImage)
    end

    it "should apply multiple CIFilters" do
      filter1 = CIFilter.gaussian_blur(1)
      filter2 = CIFilter.gaussian_blur(2)
      (@image | filter1 | filter2).should.be.kind_of(CIImage)
    end

  end

  describe "String" do
    before do
      @string = 'My name is Mud'
    end

    it "should filter Regexp" do
      ("My name is Mud" | /\w+$/).should == "Mud"
      ("My name is Mud" | /\d+$/).should == nil
    end

    it "should filter String" do
      ("My name is Mud" | "Mud").should == "Mud"
      ("My name is Mud" | "Bob").should == nil
    end

    it "should not support arbitrary coercions" do
      ->{
        (@string | ArbitraryCoercion)
      }.should.raise
    end

  end

end
