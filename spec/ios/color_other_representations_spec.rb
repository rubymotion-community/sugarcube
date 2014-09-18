describe 'UIColor, other representations' do

  it "should have a #to_i method" do
    UIColor.whiteColor.to_i.should == 16777215
    UIColor.blackColor.to_i.should == 0
  end

  it "should have a #to_a method" do
    UIColor.whiteColor.to_a.should == [255, 255, 255]
    UIColor.blackColor.to_a.should == [0, 0, 0]
  end

  it "should have a #hex method" do
    UIColor.whiteColor.hex.should == '#ffffff'
    UIColor.blackColor.hex.should == '#000000'
  end

  it "should have a #system_name method" do
    UIColor.whiteColor.system_name.should == :whiteColor
    UIColor.blackColor.system_name.should == :blackColor
    UIColor.lightGrayColor.system_name.should == :lightGrayColor
  end

  it "should return css color names" do
    corrections = {
      aqua: :cyan,
      lime: :green,
      fuchsia: :magenta,
    }
    Symbol.css_colors.each do |name, val|
      name = corrections.fetch(name, name)

      color = val.uicolor
      color.css_name.should == name
    end
  end

  it "should have good to_s return values" do
    UIColor.whiteColor.to_s.should == 'UIColor.whiteColor'
    UIColor.whiteColor.uicolor(0.5).to_s.should == 'UIColor.whiteColor.colorWithAlphaComponent(0.5)'
    :indianred.uicolor.to_s.should == ':indianred.uicolor'
    :indianred.uicolor(0.5).to_s.should == ':indianred.uicolor(0.5)'
    '#12be3f'.uicolor.to_s.should == "'#12be3f'.uicolor"
    '#12be3f'.uicolor(0.5).to_s.should == "'#12be3f'.uicolor(0.5)"
  end

  describe 'System colors' do
    Symbol.uicolors.each do |name, method|
      it "should support #{name.inspect}.uicolor" do
        name.uicolor.should.be.kind_of(UIColor)
      end
    end
  end

  describe 'CSS names' do
    Symbol.css_colors.each do |name, val|
      it "should support #{name.inspect}.uicolor" do
        name.uicolor.should.be.kind_of(UIColor)
      end
    end
  end

end
