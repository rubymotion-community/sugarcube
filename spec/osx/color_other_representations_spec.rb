describe 'NSColor, other representations' do

  it "should have a #to_i method" do
    NSColor.whiteColor.to_i.should == 16777215
    NSColor.blackColor.to_i.should == 0
  end

  it "should have a #to_a method" do
    NSColor.whiteColor.to_a.should == [255, 255, 255]
    NSColor.blackColor.to_a.should == [0, 0, 0]
  end

  it "should have a #hex method" do
    NSColor.whiteColor.hex.should == '#ffffff'
    NSColor.blackColor.hex.should == '#000000'
  end

  it "should have a #system_name method" do
    NSColor.whiteColor.system_name.should == :whiteColor
    NSColor.blackColor.system_name.should == :blackColor
    NSColor.lightGrayColor.system_name.should == :lightGrayColor
  end

  it "should return css color names" do
    corrections = {
      aqua: :cyan,
      lime: :green,
      fuchsia: :magenta,
    }
    Symbol.css_colors.each do |name, val|
      name = corrections.fetch(name, name)

      color = val.nscolor
      color.css_name.should == name
    end
  end

  it "should have good to_s return values" do
    NSColor.whiteColor.to_s.should == 'NSColor.whiteColor'
    NSColor.whiteColor.nscolor(0.5).to_s.should == 'NSColor.whiteColor.colorWithAlphaComponent(0.5)'
    :indianred.nscolor.to_s.should == ':indianred.nscolor'
    :indianred.nscolor(0.5).to_s.should == ':indianred.nscolor(0.5)'
    '#12be3f'.nscolor.to_s.should == "'#12be3f'.nscolor"
    '#12be3f'.nscolor(0.5).to_s.should == "'#12be3f'.nscolor(0.5)"
  end

  describe 'System colors' do
    Symbol.nscolors.each do |name, method|
      it "should support #{name.inspect}.nscolor" do
        name.nscolor.should.be.kind_of(NSColor)
      end
    end
  end

  describe 'CSS names' do
    Symbol.css_colors.each do |name, val|
      it "should support #{name.inspect}.nscolor" do
        name.nscolor.should.be.kind_of(NSColor)
      end
    end
  end

end
