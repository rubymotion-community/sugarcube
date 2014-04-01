describe UIAlertView do
  tests UIViewController  # this is just needed so that a window is available

  it 'should have :show option (show: false)' do
    alert = UIAlertView.alert('test', show: false)
    proper_wait 0.6
    alert.visible?.should == false
  end

  it 'should have :show option (show: true)' do
    alert = UIAlertView.alert('test', show: true)
    proper_wait 1
    alert.visible?.should == true
    alert.dismissWithClickedButtonIndex(alert.firstOtherButtonIndex, animated: false)
  end

  it 'should show by default' do
    alert = UIAlertView.alert('test')
    proper_wait 1
    alert.visible?.should == true
    alert.dismissWithClickedButtonIndex(alert.firstOtherButtonIndex, animated: false)
  end

  it 'should assign the title' do
    alert = UIAlertView.alert('test title', show: false)
    alert.title.should == 'test title'
  end

  it 'should assign the title by options' do
    alert = UIAlertView.alert(title: 'test title', show: false)
    alert.title.should == 'test title'
  end

  it 'should support three args' do
    alert = UIAlertView.alert('test title', 'test message', show: false)
    alert.title.should == 'test title'
    alert.message.should == 'test message'
    alert.visible?.should == false
  end

  it 'should assign the title and message by options' do
    alert = UIAlertView.alert(title: 'test title', message: 'test message', show: false)
    alert.title.should == 'test title'
    alert.message.should == 'test message'
    alert.visible?.should == false
  end

  describe 'assigning a message' do

    it 'should use the second arg' do
      alert = UIAlertView.alert('test title', 'test message', show: false)
      alert.message.should == 'test message'
    end

    it 'should use the :message option' do
      alert = UIAlertView.alert('test title', message: 'test message', show: false)
      alert.message.should == 'test message'
    end

  end

  it 'should have << method' do
    alert = UIAlertView.alert('test', show: false)
    -> {
      alert << 'title'
    }.should.not.raise
  end

  it 'should add a button with << method' do
    alert = UIAlertView.alert('test', show: false)
    alert << 'title'
    alert.buttonTitleAtIndex(alert.firstOtherButtonIndex + 1).should == 'title'
  end

  it 'should display "OK" when no buttons are specified' do
    alert = UIAlertView.alert('test', show: false)
    alert.cancelButtonIndex.should == -1
    alert.buttonTitleAtIndex(alert.firstOtherButtonIndex).should == 'OK'
  end

  it 'should use a cancel button if any buttons are specified' do
    alert = UIAlertView.alert('test', buttons: ['a', 'b'], show: false)
    alert.buttonTitleAtIndex(alert.cancelButtonIndex).should == 'a'
    alert.buttonTitleAtIndex(alert.firstOtherButtonIndex).should == 'b'
  end

  it 'should have :style option' do
    Symbol.uialertstyle.each do |style, value|
      # as symbol
      alert = UIAlertView.alert('test', show: false, style: style)
      alert.alertViewStyle.should == value

      # as constant
      alert = UIAlertView.alert('test', show: false, style: value)
      alert.alertViewStyle.should == value
    end
  end

  it 'should call the block when dismissed' do
    alert = UIAlertView.alert('test') { @touched = true }
    alert.numberOfButtons.should == 1
    proper_wait 0.6
    alert.dismissWithClickedButtonIndex(alert.firstOtherButtonIndex, animated: false)

    @touched.should == true
  end

  it 'should call the block and pass the button when dismissed' do
    alert = UIAlertView.alert('test') { |button| @touched = button }
    proper_wait 0.6
    alert.dismissWithClickedButtonIndex(alert.firstOtherButtonIndex, animated: false)

    @touched.should == 'OK'
  end

  it 'should call the block and pass the button and index when dismissed' do
    alert = UIAlertView.alert('test') { |button, index| @touched, @touched_index = button, index }
    proper_wait 0.6
    alert.dismissWithClickedButtonIndex(alert.firstOtherButtonIndex, animated: false)

    @touched.should == 'OK'
    @touched_index.should == 0
  end

  it 'should call the block when dismissed no matter when cancel button pressed' do
    alert = UIAlertView.alert('test', buttons:['cancel','ok']) { @touched = true }
    alert.numberOfButtons.should == 2
    proper_wait 0.6
    alert.dismissWithClickedButtonIndex(alert.cancelButtonIndex, animated: false)

    @touched.should == true
  end

  it 'should call the block and pass the button when dismissed with multiple buttons' do
    alert = UIAlertView.alert('test', buttons: ['cancel', 'ok']) { |button| @touched = button }
    proper_wait 0.6
    alert.dismissWithClickedButtonIndex(alert.cancelButtonIndex, animated: false)

    @touched.should == 'cancel'
  end

  it 'should call the block and pass the button and index when dismissed with multiple buttons' do
    alert = UIAlertView.alert('test', buttons: ['cancel', 'ok']) { |button, index| @touched, @touched_index = button, index }
    proper_wait 0.6
    alert.dismissWithClickedButtonIndex(alert.cancelButtonIndex, animated: false)

    @touched.should == 'cancel'
    @touched_index.should == 0
  end

  describe 'when :cancel and :success handlers are used' do

    before do
      @touched = nil
      @alert = UIAlertView.alert('test', buttons: ['cancel', 'ok'],
        cancel: ->{ @touched = :cancel },
        success: ->{ @touched = :success }
        )
    end

    after do
      @alert.dismissWithClickedButtonIndex(@alert.cancelButtonIndex, animated: false) if @alert.visible?
    end

    it 'should call the :cancel block' do
      proper_wait 0.6
      @alert.dismissWithClickedButtonIndex(@alert.cancelButtonIndex, animated: false)

      @touched.should == :cancel
    end

    it 'should call the :success block' do
      proper_wait 0.6
      @alert.dismissWithClickedButtonIndex(@alert.firstOtherButtonIndex, animated: false)

      @touched.should == :success
    end

  end

  describe 'should call the block and pass the button and inputs' do

    before do
      @text = nil
    end

    it 'should work with :secure_text_input' do
      @called = false
      alert = UIAlertView.alert('test', buttons: ['cancel', 'ok'], style: :secure_text_input) do |button, text|
        @called = true
        @text = text
      end
      proper_wait 0.6
      alert.textFieldAtIndex(0).text = 'test text'
      alert.dismissWithClickedButtonIndex(alert.firstOtherButtonIndex, animated: false)
      proper_wait 0.1

      @called.should == true
      @text.should == 'test text'
    end

    it 'should work with UIAlertViewStyleSecureTextInput' do
      @called = false
      alert = UIAlertView.alert('test', buttons: ['cancel', 'ok'], style: UIAlertViewStyleSecureTextInput) do |button, text|
        @called = true
        @text = text
      end
      proper_wait 0.6
      alert.textFieldAtIndex(0).text = 'test text'
      alert.dismissWithClickedButtonIndex(alert.firstOtherButtonIndex, animated: false)
      proper_wait 0.1

      @called.should == true
      @text.should == 'test text'
    end

    it 'should work with :secure_text_input and pass the index' do
      @called = false
      alert = UIAlertView.alert('test', buttons: ['cancel', 'ok'], style: :secure_text_input) do |button, text, touched_index|
        @called = true
        @text = text
        @touched_index = touched_index
      end
      proper_wait 0.6
      alert.textFieldAtIndex(0).text = 'test text'
      alert.dismissWithClickedButtonIndex(alert.firstOtherButtonIndex, animated: false)
      proper_wait 0.1

      @called.should == true
      @text.should == 'test text'
      @touched_index.should == alert.firstOtherButtonIndex
    end

    it 'should work with :plain_text_input' do
      alert = UIAlertView.alert('test', buttons: ['cancel', 'ok'], style: :plain_text_input) do |button, text|
        @text = text
      end
      proper_wait 0.6
      alert.textFieldAtIndex(0).text = 'test text'
      alert.dismissWithClickedButtonIndex(alert.cancelButtonIndex, animated: false)
      proper_wait 0.1

      @text.should == 'test text'
    end

    it 'should work with UIAlertViewStylePlainTextInput' do
      alert = UIAlertView.alert('test', buttons: ['cancel', 'ok'], style: UIAlertViewStylePlainTextInput) do |button, text|
        @text = text
      end
      proper_wait 0.6
      alert.textFieldAtIndex(0).text = 'test text'
      alert.dismissWithClickedButtonIndex(alert.cancelButtonIndex, animated: false)
      proper_wait 0.1

      @text.should == 'test text'
    end

    it 'should work with :plain_text_input and pass the index' do
      alert = UIAlertView.alert('test', buttons: ['cancel', 'ok'], style: :plain_text_input) do |button, text, touched_index|
        @text = text
        @touched_index = touched_index
      end
      proper_wait 0.6
      alert.textFieldAtIndex(0).text = 'test text'
      alert.dismissWithClickedButtonIndex(alert.cancelButtonIndex, animated: false)
      proper_wait 0.1

      @text.should == 'test text'
      @touched_index.should == alert.cancelButtonIndex
    end

    it 'should work with :login_and_password_input' do
      alert = UIAlertView.alert('test', buttons: ['cancel', 'ok'], style: :login_and_password_input) do |button, text1, text2|
        @text = "#{text1} + #{text2}"
      end
      proper_wait 0.6
      alert.textFieldAtIndex(0).text = 'test text 1'
      alert.textFieldAtIndex(1).text = 'test text 2'
      alert.dismissWithClickedButtonIndex(alert.cancelButtonIndex, animated: false)
      proper_wait 0.1

      @text.should == 'test text 1 + test text 2'
    end

    it 'should work with UIAlertViewStyleLoginAndPasswordInput' do
      alert = UIAlertView.alert('test', buttons: ['cancel', 'ok'], style: UIAlertViewStyleLoginAndPasswordInput) do |button, text1, text2|
        @text = "#{text1} + #{text2}"
      end
      proper_wait 0.6
      alert.textFieldAtIndex(0).text = 'test text 1'
      alert.textFieldAtIndex(1).text = 'test text 2'
      alert.dismissWithClickedButtonIndex(alert.cancelButtonIndex, animated: false)
      proper_wait 0.1

      @text.should == 'test text 1 + test text 2'
    end

    it 'should work with :login_and_password_input and pass the index' do
      alert = UIAlertView.alert('test', buttons: ['cancel', 'ok'], style: :login_and_password_input) do |button, text1, text2, index|
        @text = "#{text1} + #{text2}"
        @touched_index = index
      end
      proper_wait 0.6
      alert.textFieldAtIndex(0).text = 'test text 1'
      alert.textFieldAtIndex(1).text = 'test text 2'
      alert.dismissWithClickedButtonIndex(alert.cancelButtonIndex, animated: false)
      proper_wait 0.1

      @text.should == 'test text 1 + test text 2'
      @touched_index.should == alert.cancelButtonIndex
    end

  end

  describe 'with :buttons defined as a hash' do

    before do
      @touched = nil
      @alert = UIAlertView.alert('test',
        buttons: {
          cancel: 'Cancel',
          ok: 'Ok'
        }) do |button|
        @touched = button
      end
    end

    after do
      @alert.dismissWithClickedButtonIndex(@alert.cancelButtonIndex, animated: false) if @alert.visible?
    end

    it 'should work for :cancel' do
      proper_wait 0.6
      @alert.dismissWithClickedButtonIndex(@alert.cancelButtonIndex, animated: false)
      @touched.should == :cancel
    end

    it 'should work for :ok' do
      proper_wait 0.6
      @alert.dismissWithClickedButtonIndex(@alert.firstOtherButtonIndex, animated: false)
      @touched.should == :ok
    end

  end

  describe 'when :cancel and :success handlers are used and buttons as a hash' do

    before do
      @touched = nil
      @alert = UIAlertView.alert('test', buttons: {cancel: 'cancel', ok: 'ok'},
        cancel: ->{ @touched = :cancel },
        success: ->{ @touched = :success }
        )
    end

    after do
      @alert.dismissWithClickedButtonIndex(@alert.cancelButtonIndex, animated: false) if @alert.visible?
    end

    it 'should call the :cancel block' do
      proper_wait 0.6
      @alert.dismissWithClickedButtonIndex(@alert.cancelButtonIndex, animated: false)

      @touched.should == :cancel
    end

    it 'should call the :success block' do
      proper_wait 0.6
      @alert.dismissWithClickedButtonIndex(@alert.firstOtherButtonIndex, animated: false)

      @touched.should == :success
    end

  end

end
