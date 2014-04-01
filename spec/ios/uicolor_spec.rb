describe "UIColor" do

  describe "modified == method" do

    it "should be intuitive" do
      :red.uicolor.should == :red.uicolor
      :blue.uicolor.should == :blue.uicolor
      :black.uicolor.should == :black.uicolor
      :white.uicolor.should == :white.uicolor
      :clear.uicolor.should == :clear.uicolor
    end

    it "should be pretty smart" do
      :red.uicolor(0.1).should == :red.uicolor(0.1)
      :blue.uicolor(0.2).should == :blue.uicolor(0.2)
      :black.uicolor(0.3).should == :black.uicolor(0.3)
      :white.uicolor(0.4).should == :white.uicolor(0.4)
      :clear.uicolor(0.5).should == :clear.uicolor(0.5)
    end

    it "should support hex codes" do
      '#59684f'.uicolor.should == '#59684f'.uicolor
      '#b87a3b'.uicolor.should == '#b87a3b'.uicolor
      '#e0214d'.uicolor.should == '#e0214d'.uicolor
      '#51504a'.uicolor.should == '#51504a'.uicolor
      '#4dc223'.uicolor(0.5).should == '#4dc223'.uicolor(0.5)
    end

    it "should support css names" do
      :blanchedalmond.uicolor.should == :blanchedalmond.uicolor
      :chartreuse.uicolor.should == :chartreuse.uicolor
      :darkgreen.uicolor.should == :darkgreen.uicolor
      :deepskyblue.uicolor.should == :deepskyblue.uicolor
      :floralwhite.uicolor(0.5).should == :floralwhite.uicolor(0.5)
    end

  end

end
