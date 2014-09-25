describe UIFont do
  before do
    @font = UIFont.systemFontOfSize(UIFont.systemFontSize)
  end
  it 'should return self on #uifont' do
    @font.uifont.should.equal? @font
    @font.uifont.should.be.kind_of(UIFont)
  end
  it 'should return a font with a different size on #uifont(size)' do
    new_font = @font.uifont(12)
    new_font.should.be.kind_of(UIFont)
    new_font.pointSize.should == 12
    new_font.familyName.should == @font.familyName
  end
  it 'should accept font-size symbols' do
    new_font = @font.uifont(:label)
    new_font.should.be.kind_of(UIFont)
    new_font.pointSize.should == :label.uifontsize
    new_font.familyName.should == @font.familyName
  end
end
