describe "Symbol - uifont" do

  it "should work with system fonts" do
    :system.uifont.should.be.kind_of(UIFont)
    :bold.uifont.should.be.kind_of(UIFont)
    :italic.uifont.should.be.kind_of(UIFont)
  end

  it "should work with custom fonts" do
    :monospace.uifont.should != nil
    :monospace.uifont.should.be.kind_of(UIFont)
  end

  it "should allow customization" do
    Symbol.uifont[:default] = 'Helvetica'
    :default.uifont.tap do |subject|
      subject.should.be.kind_of(UIFont)
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
