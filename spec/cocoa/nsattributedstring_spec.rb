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

    it 'should have have `empty?`' do
      'test'.attrd.empty?.should == false
      ''.attrd.empty?.should == true
    end

    it 'should have `strip`' do
      'test '.attrd.strip.should == 'test'.attrd
      ' test '.attrd.strip.should == 'test'.attrd
      ' test'.attrd.strip.should == 'test'.attrd
      "\ntest".attrd.strip.should == 'test'.attrd
      "\n test".attrd.strip.should == 'test'.attrd
      "\n test \n".attrd.strip.should == 'test'.attrd
      "\n test  \n".attrd.strip.should == 'test'.attrd
      "test  ".attrd.strip.should == 'test'.attrd
      "test\n  ".attrd.strip.should == 'test'.attrd
      "  \n test".attrd.strip.should == 'test'.attrd
    end
  end

  describe "should allow joining an array of attributed strings" do
    it "should not care about standard arrays of strings" do
      joined = ['a', 'b', 'c'].join_attrd
      joined.should == 'abc'
      joined.is_a?(NSAttributedString).should == false
      joined.is_a?(NSString).should == true

      ['a', 'b', 'c'].join_attrd('-').should == 'a-b-c'
    end

    it "should join attributed strings" do
      joined = ['a'.attrd, 'b'.attrd, 'c'.attrd].join_attrd
      joined.is_a?(NSAttributedString).should == true
    end

    it "should create an attributed string even when only one item is attributed" do
      joined = ['a', 'b', 'c'.attrd].join_attrd
      joined.is_a?(NSAttributedString).should == true

      joined2 = ['a', 'b'.attrd, 'c'].join_attrd
      joined2.is_a?(NSAttributedString).should == true
    end

    it "should preserve attributes when joining" do
      joined = ['a'.italic, 'b'.bold, 'c'.underline].join_attrd
      joined.isEqualToAttributedString('a'.italic + 'b'.bold + 'c'.underline).should == true
    end

    it "should join with a string" do
      joined = ['a'.bold, 'b', 'c'].join_attrd('-')
      joined.isEqualToAttributedString('a'.bold + '-' + 'b' + '-' + 'c').should == true
    end

    it "should join with an attributed string" do
      joined = ['a'.bold, 'b', 'c'].join_attrd('-'.bold)
      joined.isEqualToAttributedString('a'.bold + '-'.bold + 'b' + '-'.bold + 'c').should == true
    end

    it "should join an array of strings with an attributed connector" do
      joined = ['a', 'b', 'c'].join_attrd('-'.bold)
      joined.isEqualToAttributedString('a'.attrd + '-'.bold + 'b' + '-'.bold + 'c').should == true
    end
  end

end
