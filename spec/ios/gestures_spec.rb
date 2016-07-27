describe 'Gestures' do
  before do
    @view = UIView.alloc.initWithFrame([[0, 0], [10, 10]])
  end

  after do
    @view.off_gestures
  end

  describe 'on_tap' do
    it 'should work' do
      gesture = @view.on_tap do |gesture|
      end
      gesture.should.be.kind_of(UITapGestureRecognizer)
      @view.gestureRecognizers.should.include?(gesture)
    end

    it 'should work with options' do
      gesture = @view.on_tap(taps: 2, fingers: 2) do |gesture|
      end
      gesture.should.be.kind_of(UITapGestureRecognizer)
      gesture.numberOfTapsRequired.should == 2
      gesture.numberOfTouchesRequired.should == 2
      @view.gestureRecognizers.should.include?(gesture)
    end
  end

  describe 'on_pinch' do
    it 'should work' do
      gesture = @view.on_pinch do |gesture|
      end
      gesture.should.be.kind_of(UIPinchGestureRecognizer)
      @view.gestureRecognizers.should.include?(gesture)
    end
  end

  describe 'on_rotate' do
    it 'should work' do
      gesture = @view.on_rotate do |gesture|
      end
      gesture.should.be.kind_of(UIRotationGestureRecognizer)
      @view.gestureRecognizers.should.include?(gesture)
    end
  end

  describe 'on_swipe' do
    it 'should work' do
      gesture = @view.on_swipe do |gesture|
      end
      gesture.should.be.kind_of(UISwipeGestureRecognizer)
      @view.gestureRecognizers.should.include?(gesture)
    end

    it 'should work with options' do
      gesture = @view.on_swipe(direction: :left, fingers: 2) do |gesture|
      end
      gesture.should.be.kind_of(UISwipeGestureRecognizer)
      gesture.direction.should == UISwipeGestureRecognizerDirectionLeft
      gesture.numberOfTouchesRequired.should == 2
      @view.gestureRecognizers.should.include?(gesture)
    end
  end

  describe 'on_pan' do
    it 'should work' do
      gesture = @view.on_pan do |gesture|
      end
      gesture.should.be.kind_of(UIPanGestureRecognizer)
      @view.gestureRecognizers.should.include?(gesture)
    end

    it 'should work with fingers options' do
      gesture = @view.on_pan(min_fingers: 2, max_fingers: 2) do |gesture|
      end
      gesture.should.be.kind_of(UIPanGestureRecognizer)
      gesture.maximumNumberOfTouches.should == 2
      gesture.minimumNumberOfTouches.should == 2
      @view.gestureRecognizers.should.include?(gesture)
    end

    it 'should work with edges option' do 
      gesture = @view.on_pan(edges: [:top, :left]) do |gesture|
      end
      gesture.should.be.kind_of(UIScreenEdgePanGestureRecognizer)
      gesture.edges.should == (:left.uirectedge + :top.uirectedge)
      @view.gestureRecognizers.should.include?(gesture)
    end

    it 'should ignore :none edges option' do 
      gesture = @view.on_pan(edges: [:none], min_fingers: 2, max_fingers: 2) do |gesture|
      end
      gesture.should.be.kind_of(UIPanGestureRecognizer)
      gesture.maximumNumberOfTouches.should == 2
      gesture.minimumNumberOfTouches.should == 2
      @view.gestureRecognizers.should.include?(gesture)
    end

    
  end

  describe 'on_press' do
    it 'should work' do
      gesture = @view.on_press do |gesture|
      end
      gesture.should.be.kind_of(UILongPressGestureRecognizer)
      @view.gestureRecognizers.should.include?(gesture)
    end

    it 'should work with options' do
      gesture = @view.on_press(duration: 1, taps: 2, fingers: 2, distance: 4) do |gesture|
      end
      gesture.should.be.kind_of(UILongPressGestureRecognizer)
      gesture.minimumPressDuration.should == 1
      gesture.numberOfTapsRequired.should == 2
      gesture.numberOfTouchesRequired.should == 2
      gesture.allowableMovement.should == 4
      @view.gestureRecognizers.should.include?(gesture)
    end
  end

  describe 'on_press_begin' do
    it 'should work' do
      gesture = @view.on_press_begin do |gesture|
      end
      gesture.should.be.kind_of(UILongPressGestureRecognizer)
      @view.gestureRecognizers.should.include?(gesture)
    end

    it 'should work with options' do
      gesture = @view.on_press_begin(duration: 1, taps: 2, fingers: 2, distance: 4) do |gesture|
      end
      gesture.should.be.kind_of(UILongPressGestureRecognizer)
      gesture.minimumPressDuration.should == 1
      gesture.numberOfTapsRequired.should == 2
      gesture.numberOfTouchesRequired.should == 2
      gesture.allowableMovement.should == 4
      @view.gestureRecognizers.should.include?(gesture)
    end
  end

  describe 'on_press_ended' do
    it 'should work' do
      gesture = @view.on_press_ended do |gesture|
      end
      gesture.should.be.kind_of(UILongPressGestureRecognizer)
      @view.gestureRecognizers.should.include?(gesture)
    end

    it 'should work with options' do
      gesture = @view.on_press_ended(duration: 1, taps: 2, fingers: 2, distance: 4) do |gesture|
      end
      gesture.should.be.kind_of(UILongPressGestureRecognizer)
      gesture.minimumPressDuration.should == 1
      gesture.numberOfTapsRequired.should == 2
      gesture.numberOfTouchesRequired.should == 2
      gesture.allowableMovement.should == 4
      @view.gestureRecognizers.should.include?(gesture)
    end
  end

end
