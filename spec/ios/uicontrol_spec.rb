describe 'UIControl' do
  describe 'should have sugarcube_callbacks' do
    before do
      @ctrl = UIButton.new
    end
    after do
      @ctrl.off
    end

    it 'should start off empty' do
      @ctrl.send(:sugarcube_callbacks).should == {}
    end

    it 'should add a touch handler' do
      @ctrl.on(:touch) {}
      @ctrl.send(:sugarcube_callbacks).length.should == 1
      @ctrl.send(:sugarcube_callbacks)[UIControlEventTouchUpInside].length.should == 1
    end

    it 'should remove the touch handler' do
      @ctrl.on(:touch) {}
      @ctrl.off
      @ctrl.send(:sugarcube_callbacks).length.should == 0
    end

    it 'should add two touch handlers' do
      @ctrl.on(:touch) {}
      @ctrl.on(:touch) {}
      @ctrl.send(:sugarcube_callbacks)[UIControlEventTouchUpInside].length.should == 2
    end

    it 'should remove both touch handlers' do
      @ctrl.on(:touch) {}
      @ctrl.on(:touch) {}
      @ctrl.off
      @ctrl.send(:sugarcube_callbacks).length.should == 0
    end

    it 'should add multiple control events' do
      @ctrl.on(:touch_start, :touch_stop) {}
      @ctrl.send(:sugarcube_callbacks)[UIControlEventTouchDown | UIControlEventTouchDragEnter].length.should == 1
      @ctrl.send(:sugarcube_callbacks)[UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchDragExit].length.should == 1
    end

    it 'should remove some events' do
      @ctrl.on(:touch_start, :touch_stop) {}
      @ctrl.off(:touch_start)
      @ctrl.send(:sugarcube_callbacks)[UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchDragExit].length.should == 1
    end

    it 'should distinguish events' do
      @ctrl.on(:touch) {}
      @ctrl.on(:touch_start, :touch_stop) {}
      @ctrl.off(:touch_start)
      @ctrl.send(:sugarcube_callbacks)[UIControlEventTouchUpInside].length.should == 1
      @ctrl.send(:sugarcube_callbacks)[UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchDragExit].length.should == 1
    end

    it 'should remove all events' do
      @ctrl.on(:touch_start, :touch_stop) {}
      @ctrl.off(:touch_start)
      @ctrl.off(:touch_stop)
      @ctrl.send(:sugarcube_callbacks).should == {}
    end

  end
end

describe 'UIControl' do
  tests UIControlController

  before do
    controller.reset
  end

  it 'should have two buttons' do
    controller.button1.should.be.kind_of(UIButton)
    controller.button2.should.be.kind_of(UIButton)
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
