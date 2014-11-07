describe 'NSAttributeString' do

  describe 'NSString attribute string methods' do

    it 'should have #underline' do
      subject = 'test'.underline
      subject.should.be.kind_of(NSAttributedString)
      subject.attributesAtIndex(0, effectiveRange:nil).should == {NSUnderlineStyleAttributeName => NSUnderlineStyleSingle}
    end

  end

  describe "should support all attribute names" do
    before do
      @subject = 'test'.attrd
    end

    it 'should have `underline_style`' do
      subject = 'test'.attrd.underline_style(NSUnderlineStyleSingle)
      subject.attributesAtIndex(0, effectiveRange:nil).should == {NSUnderlineStyleAttributeName => NSUnderlineStyleSingle}
    end

    it 'should have `underline_style`' do
      subject = 'test'.attrd.underline
      subject.attributesAtIndex(0, effectiveRange:nil).should == {NSUnderlineStyleAttributeName => NSUnderlineStyleSingle}
    end

    it 'should have `superscript`' do
      subject = 'test'.attrd.superscript
      subject.attributesAtIndex(0, effectiveRange:nil).should == {NSSuperscriptAttributeName => 1}
      subject = 'test'.attrd.superscript(2)
      subject.attributesAtIndex(0, effectiveRange:nil).should == {NSSuperscriptAttributeName => 2}
    end

    it 'should have `subscript`' do
      subject = 'test'.attrd.subscript
      subject.attributesAtIndex(0, effectiveRange:nil).should == {NSSuperscriptAttributeName => -1}
    end
  end

end
