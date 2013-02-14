class AttrUpdatesTest < UIView

  attr_updates :color
  attr :did_update

  def setNeedsDisplay
    @did_update = true
    super
  end

  def reset!
    @did_update = false
  end

end

describe 'UIView##attr_updates' do

  it 'should assign the ivar' do
    subject = AttrUpdatesTest.new
    subject.color = :red
    subject.color.should == :red
  end

  it 'should reset did_update' do
    subject = AttrUpdatesTest.new
    subject.reset!
    subject.did_update.should == false
  end

  it 'should cause setNeedsDisplay to be called' do
    subject = AttrUpdatesTest.new
    subject.reset!
    subject.did_update.should == false
    subject.color = :red  # value changed from nil
    subject.color.should == :red
    subject.did_update.should == true
  end

  it 'should not cause setNeedsDisplay to be called if the value doesn\'t change' do
    subject = AttrUpdatesTest.new
    subject.reset!
    subject.did_update.should == false
    subject.color = :red  # value changed from nil
    subject.color.should == :red
    subject.did_update.should == true
    subject.reset!
    subject.did_update.should == false
    subject.color = :red  # same value, so no update
    subject.color.should == :red
    subject.did_update.should == false
  end

end
