describe 'UIColor (CSS)' do

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
    UIColor.whiteColor.uicolor(0.5).to_s.should == 'UIColor.whiteColor(0.5)'
    :indianred.uicolor.to_s.should == 'UIColor.color(:indianred)'
    :indianred.uicolor(0.5).to_s.should == 'UIColor.color(:indianred, alpha: 0.5)'
    '#12be3f'.uicolor.to_s.should == "UIColor.color('#12be3f')"
    '#12be3f'.uicolor(0.5).to_s.should == "UIColor.color('#12be3f', alpha: 0.5)"
  end

  it "should return UIColor objects" do
    Symbol.uicolors.each do |name, method|
      name.uicolor.should == UIColor.send(method)
    end
    Symbol.css_colors.each do |name, val|
      name.uicolor.is_a?(UIColor).should == true
    end
  end

end
