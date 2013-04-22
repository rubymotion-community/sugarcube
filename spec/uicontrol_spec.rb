describe 'UIControl' do
  tests UIControlController

  before do
    controller.reset
  end

  it 'should have two buttons' do
    UIButton.should === controller.button1
    UIButton.should === controller.button2
  end

  it 'button1 should respond to touches' do
    controller.button1.sendActionsForControlEvents(:touch.uicontrolevent)
    controller.touched.should == controller.button1
    controller.touched_1.should == true
    controller.touched_count.should == 1
  end

  it 'button1 should respond to touches using `trigger`' do
    controller.button1.trigger(:touch)
    controller.touched.should == controller.button1
    controller.touched_1.should == true
    controller.touched_count.should == 1
  end

  it 'button2 should respond to touches' do
    controller.button2.sendActionsForControlEvents(:touch.uicontrolevent)
    controller.touched.should == controller.button2
    controller.touched_2.should == true
    controller.touched_count.should == 1
  end

  it 'should be able to share handlers with arity 1 (sender)' do
    controller.button1.sendActionsForControlEvents(:touch.uicontrolevent)
    controller.button2.sendActionsForControlEvents(:touch.uicontrolevent)
    controller.touched.should == controller.button2
    controller.touched_1.should == true
    controller.touched_2.should == true
    controller.touched_count.should == 2
  end

end
