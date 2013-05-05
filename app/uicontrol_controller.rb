class UIControlController < UIViewController
  attr :button1
  attr :button2
  attr :touched
  attr :touched_count
  attr :event
  attr :touched_1
  attr :touched_2

  def reset
    @touched = nil
    @touched_count = 0
    @event = nil
    @touched_1 = false
    @touched_2 = false
  end

  def loadView
    super.tap do
      @button1 = UIButton.rounded
      @button1.setTitle('one', forState: :normal.uicontrolstate)
      @button1.sizeToFit
      @button1.center = self.view.center
      self.view << @button1

      @button2 = UIButton.rounded
      @button2.setTitle('two', forState: :normal.uicontrolstate)
      @button2.sizeToFit
      @button2.center = [@button1.center.x, @button1.center.y + 30]
      @button1.center = [@button1.center.x, @button1.center.y - 30]
      self.view << @button2

      @button1.on :touch do |sender,event|
        @touched_1 = true
        @touched = sender
        @touched_count += 1
      end

      @button2.on :touch do |sender,event|
        @touched_2 = true
        @touched = sender
        @touched_count += 1
      end

      reset
    end
  end

end
