describe "UIView animation methods" do
  # the 'tumble' animation requires an app window to be present
  tests UIViewController

  before do
    @view = UIView.alloc.initWithFrame([[1,2],[3,4]])
    controller.view.addSubview(@view)
  end

  it 'should have a tumble animation' do
    @done = false
    @view.tumble
    @view.center.y.should > UIScreen.mainScreen.bounds.size.height
  end

  it 'should have a tumble animation with duration' do
    @done = false
    @view.tumble(0.4) do |finished|
      @done = finished ? :done : :unfinished
    end
    @view.center.y.should > UIScreen.mainScreen.bounds.size.height
    wait 0.3 do
      @done.should == false
      wait 0.3 do
        @done.should == :done
      end
    end
  end

  it 'should have a tumble animation with side as parameter' do
    -> do
      @view.tumble(:left)
    end.should.not.raise
  end

  it 'should have a tumble animation with duration as option' do
    @done = false
    @view.tumble(duration: 0.4) do
      @done = :done
    end
    @view.center.y.should > UIScreen.mainScreen.bounds.size.height
    wait 0.3 do
      @done.should == false
      wait 0.2 do
        @done.should == :done
      end
    end
  end

  it 'should have a tumble animation with side as option' do
    @view.tumble(side: :left)
    @view.center.y.should > UIScreen.mainScreen.bounds.size.height
  end

  it 'should have a tumble animation with invalid side option raising exception' do
    -> do
      @view.tumble(side: :this_is_silly)
    end.should.raise
  end

  it 'should have a tumble animation with duration and options' do
    @done = false
    @view.tumble(0.4, options: UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState) do
      @done = :done
    end
    @view.center.y.should > UIScreen.mainScreen.bounds.size.height
    wait 0.3 do
      @done.should == false
      wait 0.2 do
        @done.should == :done
      end
    end
  end

end
