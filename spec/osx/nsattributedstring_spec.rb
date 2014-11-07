describe 'NSAttributeString' do

  describe 'NSString attribute string methods' do

    it 'should have #bold' do
      subject = 'test'.bold
      subject.should.have_string_attributes({NSFontAttributeName => :bold.nsfont})
    end

    it 'should have #monospace' do
      subject = 'test'.monospace
      subject.should.have_string_attributes({NSFontAttributeName => :monospace.nsfont})
    end

    it 'should have #underline' do
      subject = 'test'.underline
      subject.should.have_string_attributes({NSUnderlineStyleAttributeName => NSUnderlineStyleSingle})
    end

    it 'should be chainable' do
      subject = 'test'.bold.underline
      subject.should.have_string_attributes({NSFontAttributeName => :bold.nsfont, NSUnderlineStyleAttributeName => NSUnderlineStyleSingle})
    end

  end

  describe "should support all attribute names" do
    before do
      @subject = 'test'.attrd
    end

    it 'should have `paragraph_style`' do
      par_style = NSMutableParagraphStyle.alloc.init
      par_style.alignment = NSRightTextAlignment
      'test'.attrd.paragraph_style(par_style).should.have_string_attributes({ NSParagraphStyleAttributeName => par_style })
    end

    it 'should have `font`' do
      p :bold.nsfont
      'test'.attrd.font(:bold.nsfont).should.have_string_attributes({ NSFontAttributeName => :bold.nsfont })
      p 'Helvetica'.nsfont
      'test'.attrd.font('Helvetica').should.have_string_attributes({ NSFontAttributeName => 'Helvetica'.nsfont })
    end

    it 'should have `foreground_color`' do
      'test'.attrd.foreground_color(NSColor.redColor).should.have_string_attributes({ NSForegroundColorAttributeName => NSColor.redColor })
      'test'.attrd.color(NSColor.redColor).should.have_string_attributes({ NSForegroundColorAttributeName => NSColor.redColor })
    end

    it 'should have `background_color`' do
      'test'.attrd.background_color(NSColor.redColor).should.have_string_attributes({ NSBackgroundColorAttributeName => NSColor.redColor })
      'test'.attrd.bg_color(NSColor.redColor).should.have_string_attributes({ NSBackgroundColorAttributeName => NSColor.redColor })
    end

    it 'should have `stroke_color`' do
      'test'.attrd.stroke_color(NSColor.redColor).should.have_string_attributes({ NSStrokeColorAttributeName => NSColor.redColor })
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
      subject.should.have_string_attributes({NSSuperscriptAttributeName => 1})
      subject = 'test'.attrd.superscript(2)
      subject.should.have_string_attributes({NSSuperscriptAttributeName => 2})
    end

    it 'should have `subscript`' do
      subject = 'test'.attrd.subscript
      subject.should.have_string_attributes({NSSuperscriptAttributeName => -1})
    end

    it 'should have `letterpress`' do
      'test'.attrd.letterpress.should.have_string_attributes({ NSTextEffectAttributeName => NSTextEffectLetterpressStyle })
    end
  end

end
