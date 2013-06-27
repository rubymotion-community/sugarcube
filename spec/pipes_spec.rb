class ArbitraryCoercion
end


describe "Pipes" do

  describe "UIImage Pipes" do
    before do
      @image = 'little_square'.uiimage
    end

    it "should coerce into UIImage" do
      (@image | UIImage).should.is_a(UIImage)
    end

    it "should coerce into UIView" do
      (@image | UIView).should.is_a(UIView)
    end

    it "should coerce into UIImageView" do
      (@image | UIImageView).should.is_a(UIImageView)
    end

    it "should coerce into CIImage" do
      (@image | CIImage).should.is_a(CIImage)
    end

    it "should coerce into UIColor" do
      (@image | UIColor).should.is_a(UIColor)
    end

    it "should coerce into NSData" do
      (@image | NSData).should.is_a(NSData)
    end

    it "should not support arbitrary coercions" do
      ->{
        (@image | ArbitraryCoercion)
      }.should.raise
    end

    it "should apply CIFilter" do
      filter = CIFilter.gaussian_blur
      (@image | filter).should.is_a(CIImage)
    end

    it "should apply multiple CIFilters" do
      filter1 = CIFilter.gaussian_blur(1)
      filter2 = CIFilter.gaussian_blur(2)
      (@image | filter1 | filter2).should.is_a(CIImage)
    end

  end

  describe "UIView" do
    before do
      @view = UIView.alloc.initWithFrame([[0, 0], [1, 1]])
    end

    it "should coerce into UIImage" do
      (@view | UIImage).should.is_a(UIImage)
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
      (@image | UIImage).should.is_a(UIImage)
    end

    it "should coerce into UIView" do
      (@image | UIView).should.is_a(UIView)
    end

    it "should coerce into UIImageView" do
      (@image | UIImageView).should.is_a(UIImageView)
    end

    it "should coerce into CIImage" do
      (@image | CIImage).should.is_a(CIImage)
    end

    it "should not support arbitrary coercions" do
      ->{
        (@image | ArbitraryCoercion)
      }.should.raise
    end

    it "should apply CIFilter" do
      filter = CIFilter.gaussian_blur
      (@image | filter).should.is_a(CIImage)
    end

    it "should apply multiple CIFilters" do
      filter1 = CIFilter.gaussian_blur(1)
      filter2 = CIFilter.gaussian_blur(2)
      (@image | filter1 | filter2).should.is_a(CIImage)
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
