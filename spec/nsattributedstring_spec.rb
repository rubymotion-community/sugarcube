describe 'NSAttributeString' do

  describe 'NSString attribute string methods' do

    it 'should have #bold' do
      subject = 'test'.bold
      NSAttributedString.should === subject
      subject.attributesAtIndex(0, effectiveRange:nil).should == {'NSFont' => :bold.uifont}
    end

    it 'should have #italic' do
      subject = 'test'.italic
      NSAttributedString.should === subject
      subject.attributesAtIndex(0, effectiveRange:nil).should == {'NSFont' => :italic.uifont}
    end

    it 'should have #monospace' do
      subject = 'test'.monospace
      NSAttributedString.should === subject
      subject.attributesAtIndex(0, effectiveRange:nil).should == {'NSFont' => :monospace.uifont}
    end

    it 'should have #underline' do
      subject = 'test'.underline
      NSAttributedString.should === subject
      subject.attributesAtIndex(0, effectiveRange:nil).should == {'NSUnderline' => NSUnderlineStyleSingle}
    end

    it 'should be chainable' do
      subject = 'test'.bold.underline
      NSAttributedString.should === subject
      subject.attributesAtIndex(0, effectiveRange:nil).should == {'NSFont' => :bold.uifont, 'NSUnderline' => NSUnderlineStyleSingle}
    end

  end

  describe "should support all attribute names" do
    before do
      @subject = 'test'.attrd
    end

    it "should be sane" do
      @subject.isEqualToAttributedString('test'.attrd).should == true
    end

    it 'should have `font`' do
      @subject.isEqualToAttributedString('test'.attrd.font(:bold.uifont)).should != true
      @subject.isEqualToAttributedString('test'.attrd.font('Helvetica')).should != true
    end

    it 'should have `paragraph_style`' do
      @subject.isEqualToAttributedString('test'.attrd.paragraph_style(NSMutableParagraphStyle.alloc.init.tap{|s| s.alignment = UITextAlignmentRight })).should != true
    end

    it 'should have `foreground_color`' do
      @subject.isEqualToAttributedString('test'.attrd.foreground_color(UIColor.redColor)).should != true
      @subject.isEqualToAttributedString('test'.attrd.color(UIColor.redColor)).should != true
    end

    it 'should have `underline_style`' do
      @subject.isEqualToAttributedString('test'.attrd.underline_style(NSUnderlineStyleSingle)).should != true
    end

    it 'should have `superscript`' do
      @subject.isEqualToAttributedString('test'.attrd.superscript(1)).should != true
    end

    it 'should have `background_color`' do
      @subject.isEqualToAttributedString('test'.attrd.background_color(UIColor.redColor)).should != true
      @subject.isEqualToAttributedString('test'.attrd.bg_color(UIColor.redColor)).should != true
    end

    # don't care about:
    # it 'should have `attachment`' do
    #   @subject.isEqualToAttributedString('test'.attrd.attachment()).should != true
    # end

    it 'should have `ligature`' do
      @subject.isEqualToAttributedString('test'.attrd.ligature(2)).should != true
    end

    it 'should have `baseline_offset`' do
      @subject.isEqualToAttributedString('test'.attrd.baseline_offset(1)).should != true
    end

    it 'should have `kern`' do
      @subject.isEqualToAttributedString('test'.attrd.kern(1)).should != true
    end

    it 'should have `link`' do
      @subject.isEqualToAttributedString('test'.attrd.link('http://github.com'.nsurl)).should != true
    end

    it 'should have `stroke_width`' do
      @subject.isEqualToAttributedString('test'.attrd.stroke_width(1)).should != true
    end

    it 'should have `stroke_color`' do
      @subject.isEqualToAttributedString('test'.attrd.stroke_color(UIColor.redColor)).should != true
    end

    it 'should have `underline_color`' do
      @subject.isEqualToAttributedString('test'.attrd.underline_color(UIColor.redColor)).should != true
    end

    it 'should have `strikethrough_style`' do
      @subject.isEqualToAttributedString('test'.attrd.strikethrough_style(NSUnderlineStyleSingle)).should != true
    end

    it 'should have `strikethrough_color`' do
      @subject.isEqualToAttributedString('test'.attrd.strikethrough_color(UIColor.redColor)).should != true
    end

    it 'should have `shadow`' do
      @subject.isEqualToAttributedString('test'.attrd.shadow(NSShadow.alloc.init.tap{|s|s.shadowOffset = [1,1]})).should != true
    end

    it 'should have `obliqueness`' do
      @subject.isEqualToAttributedString('test'.attrd.obliqueness(0.5)).should != true
    end

    it 'should have `expansion`' do
      @subject.isEqualToAttributedString('test'.attrd.expansion(1)).should != true
    end

    # don't care about:
    # it 'should have `cursor`' do
    #   @subject.isEqualToAttributedString('test'.attrd.cursor()).should != true
    # end

    it 'should have `tool_tip`' do
      @subject.isEqualToAttributedString('test'.attrd.tool_tip('test')).should != true
    end

    it 'should have `marked_clause_segment`' do
      @subject.isEqualToAttributedString('test'.attrd.marked_clause_segment(1)).should != true
    end

    # don't care about:
    # it 'should have `writing_direction`' do
    #   @subject.isEqualToAttributedString('test'.attrd.writing_direction()).should != true
    # end

    it 'should have `vertical_glyph_form`' do
      @subject.isEqualToAttributedString('test'.attrd.vertical_glyph_form(1)).should != true
    end

    # don't care about:
    # it 'should have `text_alternatives`' do
    #   @subject.isEqualToAttributedString('test'.attrd.text_alternatives()).should != true
    # end

  end

end
