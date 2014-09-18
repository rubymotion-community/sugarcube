class AlertControllerController < UIViewController
  attr :button1
  attr :button2

  def loadView
    super.tap do
      @button1 = UIButton.system
      @button1.setTitle('Alert style', forState: UIControlStateNormal)
      @button1.sizeToFit
      @button1.center = self.view.center
      self.view << @button1
      @button1.on :touch do |sender, event|
        UIAlertController.alert(self, 'Hello here', :buttons => {
          cancel: 'Cancel',
          destructive: 'Destruct!',
          ok: 'OK'
        }) do |button|
          NSLog('Click : %@', button.inspect)
        end
      end

      @button2 = UIButton.system
      @button2.setTitle('Actionsheet from button', forState: UIControlStateNormal)
      @button2.sizeToFit
      @button2.center = [@button1.center.x, @button1.center.y + 30]
      self.view << @button2

      @button2.on :touch do |sender, event|
        UIAlertController.alert(self, 'Hello here',
                                :style => :action_sheet,
                                :buttons => ['A button', 'Another button'],
                                :from    => @button2) do |button|
          NSLog('Click : %@', button.inspect)
        end
      end

      @button3 = UIButton.system
      @button3.setTitle('Actionsheet from button frame', forState: UIControlStateNormal)
      @button3.sizeToFit
      @button3.center = [@button2.center.x, @button2.center.y + 30]
      self.view << @button3

      @button3.on :touch do |sender, event|
        UIAlertController.alert(self, 'Hello here',
                                :style => :action_sheet,
                                :buttons => ['A button', 'Another button'],
                                :from    => @button3.frame) do |button|
          NSLog('Click : %@', button.inspect)
        end
      end

      self.navigationItem.rightBarButtonItem = UIBarButtonItem.action do
        UIAlertController.alert(self, 'Hello here',
                                :style => :action_sheet,
                                :buttons => ['A button', 'Another button'],
                                :from    => self.navigationItem.rightBarButtonItem) do |button|
          NSLog('Click : %@', button.inspect)
        end
      end
    end
  end
end