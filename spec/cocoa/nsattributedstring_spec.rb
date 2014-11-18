describe 'NSAttributeString' do
  describe "should support all attribute names" do
    before do
      @subject = 'test'.attrd
    end

    it "should be sane" do
      @subject.isEqualToAttributedString('test'.attrd).should == true
    end

    # don't care about:
    # it 'should have `attachment`' do
    #   @subject.isEqualToAttributedString('test'.attrd.attachment()).should != true
    # end

    it 'should have `ligature`' do
      'test'.attrd.ligature(2).should.have_string_attributes({ NSLigatureAttributeName => 2 })
    end

    it 'should have `kern`' do
      'test'.attrd.kern(1).should.have_string_attributes({ NSKernAttributeName => 1 })
    end

    it 'should have `stroke_width`' do
      'test'.attrd.stroke_width(1).should.have_string_attributes({ NSStrokeWidthAttributeName => 1 })
    end

    it 'should have `strikethrough_style`' do
      'test'.attrd.strikethrough_style(NSUnderlineStyleSingle).should.have_string_attributes({ NSStrikethroughStyleAttributeName => NSUnderlineStyleSingle })
    end

    it 'should have `shadow`' do
      'test'.attrd.shadow(NSShadow.alloc.init.tap{|s|s.shadowOffset = [1,1]}).should.have_string_attributes({ NSShadowAttributeName => NSShadow.alloc.init.tap{|s|s.shadowOffset = [1,1]} })
    end

    it 'should have `vertical_glyph_form`' do
      'test'.attrd.vertical_glyph_form(1).should.have_string_attributes({ NSVerticalGlyphFormAttributeName => 1 })
    end

  end

end
