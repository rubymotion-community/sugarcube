describe 'NSAttributeString' do

  describe 'NSString attribute string methods' do

    it 'should have #bold' do
      subject = 'test'.bold
      subject.should.be.kind_of(NSAttributedString)
      subject.attributesAtIndex(0, effectiveRange:nil).should == {'NSFont' => :bold.uifont}
    end

    it 'should have #italic' do
      subject = 'test'.italic
      subject.should.be.kind_of(NSAttributedString)
      subject.attributesAtIndex(0, effectiveRange:nil).should == {'NSFont' => :italic.uifont}
    end

    it 'should have #monospace' do
      subject = 'test'.monospace
      subject.should.be.kind_of(NSAttributedString)
      subject.attributesAtIndex(0, effectiveRange:nil).should == {'NSFont' => :monospace.uifont}
    end

    it 'should have #underline' do
      subject = 'test'.underline
      subject.should.be.kind_of(NSAttributedString)
      subject.attributesAtIndex(0, effectiveRange:nil).should == {'NSUnderline' => NSUnderlineStyleSingle}
    end

    it 'should be chainable' do
      subject = 'test'.bold.underline
      subject.should.be.kind_of(NSAttributedString)
      subject.attributesAtIndex(0, effectiveRange:nil).should == {'NSFont' => :bold.uifont, 'NSUnderline' => NSUnderlineStyleSingle}
    end

    it 'should convert html' do
      bold_subject = '<b>Bold</b>'.attributed_html
      emphasis_subject = '<em>Emphasis</em>'.attributed_html
      underline_subject = '<u>Underline</u>'.attributed_html

      bold_subject.should.be.kind_of(NSAttributedString)
      emphasis_subject.should.be.kind_of(NSAttributedString)
      underline_subject.should.be.kind_of(NSAttributedString)

      # Commented out tests don't work because :bold.uifont isn't the same font instance as the html converter uses.
      # bold_subject.attributesAtIndex(0, effectiveRange:nil)['NSFont'].should == :bold.uifont
      # emphasis_subject.attributesAtIndex(0, effectiveRange:nil)['NSFont'].should == :italic.uifont
      underline_subject.attributesAtIndex(0, effectiveRange:nil)['NSUnderline'].should == NSUnderlineStyleSingle
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

    it 'should have `kern`' do
      @subject.isEqualToAttributedString('test'.attrd.kern(1)).should != true
    end

    it 'should have `stroke_width`' do
      @subject.isEqualToAttributedString('test'.attrd.stroke_width(1)).should != true
    end

    it 'should have `stroke_color`' do
      @subject.isEqualToAttributedString('test'.attrd.stroke_color(UIColor.redColor)).should != true
    end

    it 'should have `strikethrough_style`' do
      @subject.isEqualToAttributedString('test'.attrd.strikethrough_style(NSUnderlineStyleSingle)).should != true
    end

    it 'should have `shadow`' do
      @subject.isEqualToAttributedString('test'.attrd.shadow(NSShadow.alloc.init.tap{|s|s.shadowOffset = [1,1]})).should != true
    end

    it 'should have `vertical_glyph_form`' do
      @subject.isEqualToAttributedString('test'.attrd.vertical_glyph_form(1)).should != true
    end

    it 'should have `letterpress`' do
      @subject.isEqualToAttributedString('test'.attrd.letterpress).should != true
    end

  end

end
