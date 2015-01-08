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

    it "should have r/g/b/hue/sat/brightness attributes" do
      '#ffffff'.uicolor.red.should == 1
      '#ffffff'.uicolor.green.should == 1
      '#ffffff'.uicolor.blue.should == 1
      '#ffffff'.uicolor.brightness.should == 1
    end

    describe "should support changing brightness" do
      # Test by using #hex as brightness will differ e.g. 0.9 vs 0.911182...
      it "should darken" do
        '#ffffff'.uicolor.darken(0.1).hex.should == '#e5e5e5'.uicolor.hex
      end
      it "should invert darken" do
        '#ffffff'.uicolor.darken(0.1).lighten(0.1).hex.should == '#ffffff'.uicolor.hex
      end
      it "should lighten" do
        '#e6e6e6'.uicolor.lighten(0.1).hex.should == '#ffffff'.uicolor.hex
      end
      it "should invert lighten" do
        '#e5e5e5'.uicolor.lighten(0.1).darken(0.1).hex.should == '#e5e5e5'.uicolor.hex
      end
    end

    describe "should support css names" do
      [
        :blanchedalmond,
        :chartreuse,
        :darkgreen,
        :deepskyblue,
        :floralwhite,
      ].each do |name|
        it "should support #{name}" do
          name.uicolor.should.be.kind_of(UIColor)
          name.uicolor(0.5).should.be.kind_of(UIColor)
          name.uicolor(0.5).alpha.round(1).should == 0.5
        end
      end
    end

  end

end
