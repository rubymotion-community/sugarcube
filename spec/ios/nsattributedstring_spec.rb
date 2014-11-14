describe 'NSAttributeString' do

  describe 'NSString attribute string methods' do

    it 'should have #bold' do
      subject = 'test'.bold
      subject.should.have_string_attributes({NSFontAttributeName => :bold.uifont})
    end

    it 'should have #italic' do
      subject = 'test'.italic
      subject.should.have_string_attributes({NSFontAttributeName => :italic.uifont})
    end

    it 'should have #monospace' do
      subject = 'test'.monospace
      subject.should.have_string_attributes({NSFontAttributeName => :monospace.uifont})
    end

    it 'should have #underline' do
      subject = 'test'.underline
      subject.should.have_string_attributes({NSUnderlineStyleAttributeName => NSUnderlineStyleSingle})
    end

    it 'should be chainable' do
      subject = 'test'.bold.underline
      subject.should.have_string_attributes({NSFontAttributeName => :bold.uifont, NSUnderlineStyleAttributeName => NSUnderlineStyleSingle})
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

    it 'should have `paragraph_style`' do
      par_style = NSMutableParagraphStyle.alloc.init
      par_style.alignment = NSTextAlignmentRight
      'test'.attrd.paragraph_style(par_style).should.have_string_attributes({ NSParagraphStyleAttributeName => par_style })
    end

    it 'should have `font`' do
      'test'.attrd.font(:bold.uifont).should.have_string_attributes({ NSFontAttributeName => :bold.uifont })
      'test'.attrd.font('Helvetica').should.have_string_attributes({ NSFontAttributeName => 'Helvetica'.uifont })
    end

    it 'should have `foreground_color`' do
      'test'.attrd.foreground_color(UIColor.redColor).should.have_string_attributes({ NSForegroundColorAttributeName => UIColor.redColor })
      'test'.attrd.color(UIColor.redColor).should.have_string_attributes({ NSForegroundColorAttributeName => UIColor.redColor })
    end

    it 'should have `background_color`' do
      'test'.attrd.background_color(UIColor.redColor).should.have_string_attributes({ NSBackgroundColorAttributeName => UIColor.redColor })
      'test'.attrd.bg_color(UIColor.redColor).should.have_string_attributes({ NSBackgroundColorAttributeName => UIColor.redColor })
    end

    it 'should have `stroke_color`' do
      'test'.attrd.stroke_color(UIColor.redColor).should.have_string_attributes({ NSStrokeColorAttributeName => UIColor.redColor })
    end

    it 'should have `underline_style`' do
      subject = 'test'.attrd.underline_style(NSUnderlineStyleSingle)
      subject.should.have_string_attributes({NSUnderlineStyleAttributeName => NSUnderlineStyleSingle})
    end

    it 'should have `underline_style`' do
      subject = 'test'.attrd.underline
      subject.should.have_string_attributes({NSUnderlineStyleAttributeName => NSUnderlineStyleSingle})
    end

    it 'should have `superscript`' do
      subject = 'test'.attrd.superscript
      subject.should.have_string_attributes({KCTSuperscriptAttributeName => 1})
      subject = 'test'.attrd.superscript(2)
      subject.should.have_string_attributes({KCTSuperscriptAttributeName => 2})
    end

    it 'should have `subscript`' do
      subject = 'test'.attrd.subscript
      subject.should.have_string_attributes({KCTSuperscriptAttributeName => -1})
    end

    it 'should have `letterpress`' do
      'test'.attrd.letterpress.should.have_string_attributes({ NSTextEffectAttributeName => NSTextEffectLetterpressStyle })
    end
  end

end
