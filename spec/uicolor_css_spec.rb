describe 'UIColor (CSS)' do

  it "should return css color names" do
    except_for = [:aqua, :fuchsia, :lime]
    Symbol.css_colors.each do |name, val|
      next if except_for.include? name

      color = val.uicolor
      color.css_name.should == name
      color.to_s.should == "UIColor.color(#{name.inspect})"
    end
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
