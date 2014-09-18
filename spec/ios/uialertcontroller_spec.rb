if defined?(UIAlertControllerStyleAlert)
  describe UIAlertController do
    tests UIViewController

    it 'should have :show option (show: false)' do
      alert = UIAlertController.alert(controller, 'test', show: false)
      wait 0.6 do
        alert.presentingViewController.should == nil
      end
    end

    it 'should show by default' do
      alert = UIAlertController.alert(controller, 'test')
      wait 0.6 do
        alert.presentingViewController.should == controller
        controller.dismissViewControllerAnimated(false, completion: nil)
      end
    end

    it 'should assign the title' do
      alert = UIAlertController.alert(controller, 'test title', show: false)
      alert.title.should == 'test title'
      wait 0.001 do
        controller.dismissViewControllerAnimated(false, completion: nil)
      end
    end

    it 'should assign the title by options' do
      alert = UIAlertController.alert(controller, title: 'test title', show: false)
      alert.title.should == 'test title'
      wait 0.001 do
        controller.dismissViewControllerAnimated(false, completion: nil)
      end
    end

    it 'should have :style option' do
      Symbol.uialertcontrollerstyle.each do |style, value|
        # as symbol
        alert = UIAlertController.alert(controller, 'test', show: false, style: style)
        alert.preferredStyle.should == value

        # as constant
        alert = UIAlertController.alert(controller, 'test', show: false, style: value)
        alert.preferredStyle.should == value
      end
    end

    it 'should have :from option that accepts CGRect' do
      alert = UIAlertController.alert(controller, 'test', from: CGRect.new([0, 0], [320, 0]))
      wait 0.6 do
        alert.presentingViewController.should == controller
        controller.dismissViewControllerAnimated(false, completion: nil)
      end
    end


    it 'should have :from option that accepts CGRect and a :view that accepts UIView' do
      view   = UIView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
      window = UIApplication.sharedApplication.windows[0]
      window << view
      alert = UIAlertController.alert(controller, 'test', from: CGRect.new([0, 0], [320, 0]), view: view)
      wait 0.6 do
        alert.presentingViewController.should == controller
        controller.dismissViewControllerAnimated(false, completion: nil)
      end
    end

    it 'should have :from option that accepts UIBarButtonItem' do
      button        = UIBarButtonItem.done
      toolbar       = UIToolbar.alloc.initWithFrame(UIScreen.mainScreen.bounds)
      toolbar.items = [button]
      window        = UIApplication.sharedApplication.windows[0]
      window << toolbar
      alert = UIAlertController.alert(controller, 'test', from: button)
      wait 0.6 do
        alert.presentingViewController.should == controller
        controller.dismissViewControllerAnimated(false, completion: nil)
      end
    end

    it 'should have :from option that accepts UIView' do
      view = UIView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
      window = UIApplication.sharedApplication.windows[0]
      window << view
      alert = UIAlertController.alert(controller, 'test', from: view)
      wait 0.6 do
        alert.presentingViewController.should == controller
        controller.dismissViewControllerAnimated(false, completion: nil)
      end
    end

    it 'should add a button with << method' do
      alert = UIAlertController.alert(controller, 'test', show: false)
      alert << 'title'
      alert.actions.lastObject.title.should == 'title'
    end

    it 'should show "OK" by default as first button' do
      alert = UIAlertController.alert(controller, 'test', show: false)
      alert.actions[0].title.should == 'OK'
    end

    it 'should show "Cancel" by default as second button' do
      alert = UIAlertController.alert(controller, 'test', show: false)
      alert.actions[1].title.should == 'Cancel'
    end

    it 'should have :buttons option' do
      alert = UIAlertController.alert(controller, 'test', :buttons => %w(Hello World From Test), show: false)
      alert.actions.count.should == 4
    end

    it 'should support Hash for :buttons option' do
      alert = UIAlertController.alert(controller, 'test', :buttons => {
        cancel: 'Nevermind',
        ok: 'OK',
        destructive: 'Do eet',
        other: 'Other',
        }, show: false)
      alert.actions.count.should == 4
      alert.actions[0].title.should == 'Nevermind'
      alert.actions[0].style.should == UIAlertActionStyleCancel
      alert.actions[1].title.should == 'OK'
      alert.actions[1].style.should == UIAlertActionStyleDefault
      alert.actions[2].title.should == 'Do eet'
      alert.actions[2].style.should == UIAlertActionStyleDestructive
      alert.actions[3].title.should == 'Other'
      alert.actions[3].style.should == UIAlertActionStyleDefault
    end

  end
end
