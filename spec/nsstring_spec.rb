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

  describe "should have a #uicolor method" do
    it "that supports hex" do
      color = '#ffffff'.uicolor
      UIColor.should === color
      color.red.should == 1.0
      color.green.should == 1.0
      color.blue.should == 1.0

      color = '#808080'.uicolor
      UIColor.should === color
      ((color.red * 2).round / 2.0).should == 0.5
      ((color.green * 2).round / 2.0).should == 0.5
      ((color.blue * 2).round / 2.0).should == 0.5
    end

    it "that supports image names" do
      'little_square'.uicolor.should == 'little_square'.uiimage.uicolor
    end

    it "that supports non-existant image names" do
      'this is not my beautiful house!'.uicolor.should == nil
    end
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

end
