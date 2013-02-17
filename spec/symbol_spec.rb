describe "Symbol" do

  describe "uifont" do
    it "should work with system fonts" do
      UIFont.should === :system.uifont
      UIFont.should === :bold.uifont
      UIFont.should === :italic.uifont
    end

    it "should work with custom fonts" do
      :monospace.uifont.should != nil
      UIFont.should === :monospace.uifont
    end

    it "should allow customization" do
      Symbol.system_fonts[:default] = 'Helvetica'
      :default.uifont.tap do |subject|
        UIFont.should === subject
        subject.fontName.should == 'Helvetica'
      end
    end

    it "should accept point size" do
      :system.uifont(40).pointSize.should == 40
    end

    it "should accept symbol size" do
      :system.uifont(:label).pointSize.should == UIFont.labelFontSize
    end

  end
end
