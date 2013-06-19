describe "UIImage#color_at" do
  before do
    @image = 'little_square'.uiimage
  end

  describe "should return white at the corners" do
    it "top_left" do
      color = @image.color_at([0, 0])
      color.red.should == 1
      color.green.should == 1
      color.blue.should == 1
    end
    it "top_right" do
      color = @image.color_at([9, 0])
      color.red.should == 1
      color.green.should == 1
      color.blue.should == 1
    end
    it "bottom_left" do
      color = @image.color_at([0, 9])
      color.red.should == 1
      color.green.should == 1
      color.blue.should == 1
    end
    it "bottom_right" do
      color = @image.color_at([9, 9])
      color.red.should == 1
      color.green.should == 1
      color.blue.should == 1
    end
  end

  describe "should return blue at the center" do
    it "3,3" do
      color = @image.color_at([3, 3])
      color.red.should == 0
      color.green.should == 0
      color.blue.should == 1
    end
    it "4,4" do
      color = @image.color_at([4, 4])
      color.red.should == 0
      color.green.should == 0
      color.blue.should == 1
    end
    it "5,5" do
      color = @image.color_at([5, 5])
      color.red.should == 0
      color.green.should == 0
      color.blue.should == 1
    end
    it "6,6" do
      color = @image.color_at([6, 6])
      color.red.should == 0
      color.green.should == 0
      color.blue.should == 1
    end
  end
end
