describe UIButton do

  before do
    @subject = UIButton.new
  end

  it 'should set the title using `title=`' do
    @subject.title = 'foo'
    @subject.titleForState(UIControlStateNormal).should == 'foo'
  end

  it 'should set the title using `setTitle()`' do
    @subject.setTitle('foo')
    @subject.titleForState(UIControlStateNormal).should == 'foo'
  end

  it 'should get the title' do
    @subject.setTitle('foo', forState: UIControlStateNormal)
    @subject.title.should == 'foo'
  end

  it 'should set the titleColor using `titleColor=`' do
    @subject.titleColor = UIColor.whiteColor
    @subject.titleColorForState(UIControlStateNormal).should == UIColor.whiteColor
  end

  it 'should set the titleColor using `title_color=`' do
    @subject.title_color = UIColor.whiteColor
    @subject.titleColorForState(UIControlStateNormal).should == UIColor.whiteColor
  end

  it 'should set the titleColor using `setTitleColor()`' do
    @subject.setTitleColor(UIColor.whiteColor)
    @subject.titleColorForState(UIControlStateNormal).should == UIColor.whiteColor
  end

  it 'should get the titleColor' do
    @subject.setTitleColor(UIColor.whiteColor, forState: UIControlStateNormal)
    @subject.titleColor.should == UIColor.whiteColor
  end

  it 'should get the title_color' do
    @subject.setTitleColor(UIColor.whiteColor, forState: UIControlStateNormal)
    @subject.title_color.should == UIColor.whiteColor
  end

  it 'should set the attributedTitle using `attributedTitle=`' do
    @subject.attributedTitle = 'foo'.attrd
    @subject.attributedTitleForState(UIControlStateNormal).should == 'foo'.attrd
  end

  it 'should set the attributedTitle using `attributed_title=`' do
    @subject.attributed_title = 'foo'.attrd
    @subject.attributedTitleForState(UIControlStateNormal).should == 'foo'.attrd
  end

  it 'should set the attributedTitle using `setAttributedTitle()`' do
    @subject.setAttributedTitle('foo'.attrd)
    @subject.attributedTitleForState(UIControlStateNormal).should == 'foo'.attrd
  end

  it 'should get the attributedTitle' do
    @subject.setAttributedTitle('foo'.attrd, forState: UIControlStateNormal)
    @subject.attributedTitle.should == 'foo'.attrd
  end

  it 'should get the attributed_title' do
    @subject.setAttributedTitle('foo'.attrd, forState: UIControlStateNormal)
    @subject.attributed_title.should == 'foo'.attrd
  end

end
