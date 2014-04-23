describe "NSString" do

  it "should have a #nsurl method" do
    url = 'https://github.com/status'.nsurl
    NSURL.should === url
    url.absoluteString.should == 'https://github.com/status'
    url.host.should == 'github.com'
  end

  it "should have a #nsdata method" do
    data = 'test'.nsdata
    NSData.should === data
    bytes = data.bytes
    bytes[0].should == 116
    bytes[1].should == 101
    bytes[2].should == 115
    bytes[3].should == 116
  end

  it "should have a #uiimage method" do
    UIImage.imageNamed('little_square').should == 'little_square'.uiimage
  end

  it "should have a #uiimageview method" do
    view = 'little_square'.uiimageview
    UIView.should === view
    view.image.should == UIImage.imageNamed('little_square')
  end

  it "should have a #uifont method" do
    font = 'Helvetica'.uifont
    UIFont.should === font
    font.familyName.should == 'Helvetica'
    font.pointSize.should == UIFont.systemFontSize
  end

  it "should have a #uilabel method" do
    str = 'test'
    str_size = str.sizeWithFont(UIFont.systemFontOfSize(UIFont.labelFontSize))
    label = str.uilabel
    label.size.width.should == str_size.width
    label.size.height.should == str_size.height
    label.backgroundColor.should == UIColor.clearColor
  end

  it "should have a #uilabel(font) method" do
    str = 'test'
    font =  UIFont.boldSystemFontOfSize(20)
    str_size = str.sizeWithFont(font)
    label = str.uilabel(font)
    label.font.should == font
    label.size.width.should == str_size.width
    label.size.height.should == str_size.height
    label.backgroundColor.should == UIColor.clearColor
  end

  it "should have a #escape_url method" do
    ' '.escape_url.should == '%20'
    '?<>&=;%'.escape_url.should == '%3F%3C%3E%26%3D%3B%25'
  end

  it "should have a #unescape_url method" do
    '%20'.unescape_url.should == ' '
    '%3F%3C%3E%26%3D%3B%25'.unescape_url.should == '?<>&=;%'
  end

  it "should have a #localized method" do
    'hello'.localized.should == 'howdy'
    'hello'._.should == 'howdy'
  end

  describe "should have a #nan? method" do
    it 'should return true for non-numbers' do
      "pi".nan?.should.equal true
    end

    it 'should return false for numbers' do
      "3.12159".nan?.should.equal false
    end

    it 'should not detect currencies' do
      "$3.12159".nan?.should.equal true
    end

    it 'should return false for valid currencies' do
      "$3.12159".nan?(:currency).should.equal false
    end
  end

  describe "should have a #to_number method" do
    it 'should detect simple integers' do
      '123'.to_number.should == 123
      '1,000'.to_number.should == 1000
    end

    it 'should detect simple floats' do
      '1.25'.to_number.should == 1.25
      '1,000.25'.to_number.should == 1000.25
    end

    it 'should return nil for non-numbers' do
      'pi'.to_number.should == nil
    end

    it 'should parse currencies' do
      '$123.25'.to_number(:currency).should == 123.25
    end
  end

  it "should have a #remove_accents method" do
    'çan thîs tést ruñ òk?'.remove_accents.should == 'can this test run ok?'
  end

end
