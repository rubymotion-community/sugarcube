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

end
