describe 'Symbol#uicolor' do

  it "should return css color names" do
    Symbol.css_colors.each do |name, val|
      color = val.uicolor
      color.to_s.should == "UIColor.color(#{name.inspect})"
    end
  end

end
