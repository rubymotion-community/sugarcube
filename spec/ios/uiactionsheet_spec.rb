describe UIActionSheet do
  tests UIViewController  # this is just needed so that a window is available

  before do
    @touched = nil
  end

  it 'should have :show option (show: false)' do
    alert = UIActionSheet.alert('test', show: false)
    proper_wait 0.5
    alert.visible?.should == false
  end

  it 'should have :show option (show: true)' do
    alert = UIActionSheet.alert('test', show: true)
    proper_wait 0.5
    alert.visible?.should == true
    alert.dismissWithClickedButtonIndex(alert.firstOtherButtonIndex, animated: false)
  end

  it 'should show by default' do
    alert = UIActionSheet.alert('test')
    proper_wait 0.5
    alert.visible?.should == true
    alert.dismissWithClickedButtonIndex(alert.firstOtherButtonIndex, animated: false)
  end

  it 'should assign the title' do
    alert = UIActionSheet.alert('test title', show: false)
    alert.title.should == 'test title'
  end

  it 'should assign the title by options' do
    alert = UIActionSheet.alert(title: 'test title', show: false)
    alert.title.should == 'test title'
  end

  it 'should have << method' do
    alert = UIActionSheet.alert('test', show: false)
    -> {
      alert << 'title'
    }.should.not.raise
  end

  it 'should have :style option' do
    Symbol.uiactionstyle.each do |style, value|
      # as symbol
      alert = UIActionSheet.alert('test', show: false, style: style)
      alert.actionSheetStyle.should == value

      # as constant
      alert = UIActionSheet.alert('test', show: false, style: value)
      alert.actionSheetStyle.should == value
    end
  end

  it 'should have :from option that accepts CGRect' do
    alert = UIActionSheet.alert('test', from: CGRect.new([0, 0], [320, 0]))
    proper_wait 0.5
    alert.visible?.should == true
    alert.dismissWithClickedButtonIndex(alert.firstOtherButtonIndex, animated: false)
  end

  it 'should have :from option that accepts CGRect and a :view that accepts UIView' do
    view = UIView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    window = UIApplication.sharedApplication.windows[0]
    window << view
    alert = UIActionSheet.alert('test', from: CGRect.new([0, 0], [320, 0]), view: view)
    proper_wait 0.5
    alert.visible?.should == true
    alert.dismissWithClickedButtonIndex(alert.firstOtherButtonIndex, animated: false)
  end

  it 'should have :from option that accepts CGRect and a :view that accepts UIView' do
    view = UIView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    window = UIApplication.sharedApplication.windows[0]
    window << view
    alert = UIActionSheet.alert('test', from: CGRect.new([0, 0], [320, 0]), view: view)
    proper_wait 0.6
    alert.visible?.should == true
    alert.dismissWithClickedButtonIndex(alert.firstOtherButtonIndex, animated: false)
  end

  it 'should have :from option that accepts UIBarButtonItem' do
    button = UIBarButtonItem.done
    toolbar = UIToolbar.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    toolbar.items = [button]
    window = UIApplication.sharedApplication.windows[0]
    window << toolbar
    alert = UIActionSheet.alert('test', from: button)
    proper_wait 0.5
    alert.visible?.should == true
    alert.dismissWithClickedButtonIndex(alert.firstOtherButtonIndex, animated: false)
  end

  it 'should have :from option that accepts UIToolbar' do
    view = UIToolbar.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    window = UIApplication.sharedApplication.windows[0]
    window << view
    alert = UIActionSheet.alert('test', from: view)
    proper_wait 0.5
    alert.visible?.should == true
    alert.dismissWithClickedButtonIndex(alert.firstOtherButtonIndex, animated: false)
  end

  it 'should have :from option that accepts UITabBar' do
    view = UITabBar.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    window = UIApplication.sharedApplication.windows[0]
    window << view
    alert = UIActionSheet.alert('test', from: view)
    proper_wait 0.5
    alert.visible?.should == true
    alert.dismissWithClickedButtonIndex(alert.firstOtherButtonIndex, animated: false)
  end

  it 'should have :from option that accepts UIView' do
    view = UIView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    window = UIApplication.sharedApplication.windows[0]
    window << view
    alert = UIActionSheet.alert('test', from: view)
    proper_wait 0.5
    alert.visible?.should == true
    alert.dismissWithClickedButtonIndex(alert.firstOtherButtonIndex, animated: false)
  end

  it 'should add a button with << method' do
    alert = UIActionSheet.alert('test', show: false)
    alert << 'title'
    alert.buttonTitleAtIndex(alert.firstOtherButtonIndex + 1).should == 'title'
  end

  it 'should show "OK" by default' do
    alert = UIActionSheet.alert('test', show: false)
    alert.cancelButtonIndex.should == -1
    alert.destructiveButtonIndex.should == -1
    alert.firstOtherButtonIndex.should == 0
    alert.buttonTitleAtIndex(alert.firstOtherButtonIndex).should == 'OK'
  end

  it 'should call block when pressed' do
    alert = UIActionSheet.alert('test') { @touched = true }
    proper_wait 0.5
    alert.dismissWithClickedButtonIndex(alert.firstOtherButtonIndex, animated: false)
    proper_wait 0.5
    @touched.should == true
  end

  it 'should call block with "OK" pressed' do
    alert = UIActionSheet.alert('test') { |button, index| @touched, @touched_index = button, index }
    proper_wait 0.5
    alert.dismissWithClickedButtonIndex(alert.firstOtherButtonIndex, animated: false)
    proper_wait 0.5
    @touched.should == 'OK'
  end

  describe 'with all :buttons defined' do

    before do
      @touched = nil
      @touched_index = nil
      @alert = UIActionSheet.alert('test', buttons: ['cancel', 'destructive', 'ok']) { |button, index| @touched, @touched_index = button, index }
      proper_wait 0.5
    end

    it 'should call block with "cancel" when cancel button is pressed' do
      @alert.cancelButtonIndex.should == 2
      @alert.dismissWithClickedButtonIndex(@alert.cancelButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == 'cancel'
    end

    it 'should call block with "destructive" when destructive button is pressed' do
      @alert.destructiveButtonIndex.should == 0
      @alert.dismissWithClickedButtonIndex(@alert.destructiveButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == 'destructive'
    end

    it 'should call block with "ok" when other button is pressed' do
      @alert.firstOtherButtonIndex.should == 1
      @alert.dismissWithClickedButtonIndex(@alert.firstOtherButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == 'ok'
    end

  end

  describe 'with cancel and destructive :buttons defined' do

    before do
      @touched = nil
      @touched_index = nil
      @alert = UIActionSheet.alert('test', buttons: ['cancel', 'destructive']) { |button, index| @touched, @touched_index = button, index }
      proper_wait 0.5
    end

    after do
      @alert.dismissWithClickedButtonIndex(-1, animated: false) if @alert.visible?
    end

    it 'should call block with "cancel" when cancel button is pressed' do
      @alert.cancelButtonIndex.should == 1
      @alert.dismissWithClickedButtonIndex(@alert.cancelButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == 'cancel'
      @touched_index.should == @alert.cancelButtonIndex
    end

    it 'should call block with "destructive" when destructive button is pressed' do
      @alert.destructiveButtonIndex.should == 0
      @alert.dismissWithClickedButtonIndex(@alert.destructiveButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == 'destructive'
      @touched_index.should == @alert.destructiveButtonIndex
    end

    it 'should not have other buttons' do
      @alert.firstOtherButtonIndex.should == -1
    end

  end

  describe 'with cancel and other :buttons defined' do

    before do
      @touched = nil
      @touched_index = nil
      @alert = UIActionSheet.alert('test', buttons: ['cancel', nil, 'ok']) { |button, index| @touched, @touched_index = button, index }
      proper_wait 0.5
    end

    after do
      @alert.dismissWithClickedButtonIndex(-1, animated: false) if @alert.visible?
    end

    it 'should call block with "cancel" when cancel button is pressed' do
      @alert.cancelButtonIndex.should == 1
      @alert.dismissWithClickedButtonIndex(@alert.cancelButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == 'cancel'
      @touched_index.should == @alert.cancelButtonIndex
    end

    it 'should not have destructive button' do
      @alert.destructiveButtonIndex.should == -1
    end

    it 'should call block with "ok" when other button is pressed' do
      @alert.firstOtherButtonIndex.should == 0
      @alert.dismissWithClickedButtonIndex(@alert.firstOtherButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == 'ok'
      @touched_index.should == @alert.firstOtherButtonIndex
    end

  end

  describe 'with destructive and other :buttons defined' do

    before do
      @touched = nil
      @touched_index = nil
      @alert = UIActionSheet.alert('test', buttons: [nil, 'destructive', 'ok']) { |button, index| @touched, @touched_index = button, index }
      proper_wait 0.5
    end

    after do
      @alert.dismissWithClickedButtonIndex(-1, animated: false) if @alert.visible?
    end

    it 'should not have cancel button' do
      @alert.cancelButtonIndex.should == -1
    end

    it 'should call block with "destructive" when destructive button is pressed' do
      @alert.destructiveButtonIndex.should == 0
      @alert.dismissWithClickedButtonIndex(@alert.destructiveButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == 'destructive'
      @touched_index.should == @alert.destructiveButtonIndex
    end

    it 'should call block with "ok" when other button is pressed' do
      @alert.firstOtherButtonIndex.should == 1
      @alert.dismissWithClickedButtonIndex(@alert.firstOtherButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == 'ok'
      @touched_index.should == @alert.firstOtherButtonIndex
    end

  end

  describe 'with other :buttons defined' do

    before do
      @touched = nil
      @touched_index = nil
      @alert = UIActionSheet.alert('test', buttons: [nil, nil, 'test1', 'test2']) { |button, index| @touched, @touched_index = button, index }
      proper_wait 0.5
    end

    after do
      @alert.dismissWithClickedButtonIndex(-1, animated: false) if @alert.visible?
    end

    it 'should not have cancel button' do
      @alert.cancelButtonIndex.should == -1
    end

    it 'should not have destructive button' do
      @alert.destructiveButtonIndex.should == -1
    end

    it 'should call block with "test1" when first button is pressed' do
      @alert.firstOtherButtonIndex.should == 0
      @alert.dismissWithClickedButtonIndex(@alert.firstOtherButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == 'test1'
      @touched_index.should == @alert.firstOtherButtonIndex
    end

    it 'should call block with "test2" when second button is pressed' do
      @alert.dismissWithClickedButtonIndex(@alert.firstOtherButtonIndex + 1, animated: false)
      proper_wait 0.5
      @touched.should == 'test2'
      @touched_index.should == @alert.firstOtherButtonIndex + 1
    end

  end

  describe 'with :buttons defined as a hash' do

    before do
      @touched = nil
      @touched_index = nil
      @alert = UIActionSheet.alert('test',
        buttons: {
          cancel: 'Cancel',
          destructive: 'Destructive',
          test1: 'Test1',
          test2: 'Test2',
        }) { |button, index| @touched, @touched_index = button, index }
      proper_wait 0.5
    end

    it 'should call block with :destructive when cancel button is pressed' do
      @alert.destructiveButtonIndex.should == 0
      @alert.dismissWithClickedButtonIndex(@alert.destructiveButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == :destructive
      @touched_index.should == @alert.destructiveButtonIndex
    end

    it 'should call block with :cancel when cancel button is pressed' do
      @alert.cancelButtonIndex.should == 3
      @alert.dismissWithClickedButtonIndex(@alert.cancelButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == :cancel
      @touched_index.should == @alert.cancelButtonIndex
    end

    it 'should call block with :test1 when first button is pressed' do
      @alert.firstOtherButtonIndex.should == 1
      @alert.dismissWithClickedButtonIndex(@alert.firstOtherButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == :test1
      @touched_index.should == @alert.firstOtherButtonIndex
    end

    it 'should call block with :test2 when second button is pressed' do
      @alert.dismissWithClickedButtonIndex(@alert.firstOtherButtonIndex + 1, animated: false)
      proper_wait 0.5
      @touched.should == :test2
      @touched_index.should == @alert.firstOtherButtonIndex + 1
    end

  end

  describe 'with all handlers defined' do

    before do
      @touched = nil
      @touched_index = nil
      @alert = UIActionSheet.alert('test',
        buttons: ['cancel', 'destructive', 'test1', 'test2'],
        cancel: ->{ @touched = :cancel },
        destructive: ->{ @touched = :destructive },
        success: ->(button, index){ @touched, @touched_index = button, index },
        )
      proper_wait 0.5
    end

    it 'should call block with :cancel when cancel button is pressed' do
      @alert.cancelButtonIndex.should == 3
      @alert.dismissWithClickedButtonIndex(@alert.cancelButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == :cancel
    end

    it 'should call block with :destructive when destructive button is pressed' do
      @alert.destructiveButtonIndex.should == 0
      @alert.dismissWithClickedButtonIndex(@alert.destructiveButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == :destructive
    end

    it 'should call block with "test1" when first button is pressed' do
      @alert.firstOtherButtonIndex.should == 1
      @alert.dismissWithClickedButtonIndex(@alert.firstOtherButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == 'test1'
      @touched_index.should == @alert.firstOtherButtonIndex
    end

    it 'should call block with "test2" when second button is pressed' do
      @alert.dismissWithClickedButtonIndex(@alert.firstOtherButtonIndex + 1, animated: false)
      proper_wait 0.5
      @touched.should == 'test2'
      @touched_index.should == @alert.firstOtherButtonIndex + 1
    end

  end

  describe 'with all handlers defined and buttons as a hash' do

    before do
      @touched = nil
      @touched_index = nil
      @alert = UIActionSheet.alert('test',
        buttons: {cancel: 'cancel', destructive: 'destructive', test1: 'test1', test2: 'test2'},
        cancel: ->{ @touched = :cancel },
        destructive: ->{ @touched = :destructive },
        success: ->(button, index){ @touched, @touched_index = button, index },
        )
      proper_wait 0.5
    end

    it 'should call block with :cancel when cancel button is pressed' do
      @alert.cancelButtonIndex.should == 3
      @alert.dismissWithClickedButtonIndex(@alert.cancelButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == :cancel
    end

    it 'should call block with :destructive when destructive button is pressed' do
      @alert.destructiveButtonIndex.should == 0
      @alert.dismissWithClickedButtonIndex(@alert.destructiveButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == :destructive
    end

    it 'should call block with "test1" when first button is pressed' do
      @alert.firstOtherButtonIndex.should == 1
      @alert.dismissWithClickedButtonIndex(@alert.firstOtherButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == :test1
      @touched_index.should == @alert.firstOtherButtonIndex
    end

    it 'should call block with "test2" when second button is pressed' do
      @alert.dismissWithClickedButtonIndex(@alert.firstOtherButtonIndex + 1, animated: false)
      proper_wait 0.5
      @touched.should == :test2
      @touched_index.should == @alert.firstOtherButtonIndex + 1
    end

  end

  describe 'with success handler defined' do

    before do
      @touched = nil
      @touched_index = nil
      @alert = UIActionSheet.alert('test',
        buttons: ['cancel', 'destructive', 'test1', 'test2'],
        success: ->(button, index){ @touched, @touched_index = button, index },
        )
      proper_wait 0.5
    end

    it 'should not call block when cancel button is pressed' do
      @alert.cancelButtonIndex.should == 3
      @alert.dismissWithClickedButtonIndex(@alert.cancelButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == nil
    end

    it 'should not call block when destructive button is pressed' do
      @alert.destructiveButtonIndex.should == 0
      @alert.dismissWithClickedButtonIndex(@alert.destructiveButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == nil
    end

    it 'should call block with "test1" when first button is pressed' do
      @alert.firstOtherButtonIndex.should == 1
      @alert.dismissWithClickedButtonIndex(@alert.firstOtherButtonIndex, animated: false)
      proper_wait 0.5
      @touched.should == 'test1'
      @touched_index.should == @alert.firstOtherButtonIndex
    end

    it 'should call block with "test2" when second button is pressed' do
      @alert.dismissWithClickedButtonIndex(@alert.firstOtherButtonIndex + 1, animated: false)
      proper_wait 0.5
      @touched.should == 'test2'
      @touched_index.should == @alert.firstOtherButtonIndex + 1
    end

  end

end
