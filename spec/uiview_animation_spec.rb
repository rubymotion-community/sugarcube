describe "UIView animation methods" do
  before do
    @view = UIView.alloc.initWithFrame([[1,2],[3,4]])
  end

  it 'should delta_to x:1 y:2' do
    @view.delta_to([1,2]).frame.should == CGRectMake(2,4,3,4)
  end

  it 'should rotate 45 degrees' do
    angle = 45*Math::PI/180
    @view.rotate_to(angle)
    current_angle = Math.atan2(@view.transform.b, @view.transform.a)
    current_angle.should == angle
  end

  it 'should animate anything' do
    UIView.animate {
      @view.frame = [[0, 0], [0, 0]]
    }
    CGRectEqualToRect(@view.frame, [[0, 0], [0, 0]]).should == true
  end

  it 'should call the after block anything' do
    @after_called = false
    UIView.animate(after:->{ @after_called = true }, duration: 0.05) {
      @view.frame = [[0, 0], [0, 0]]
      @after_called = :animating
    }
    @after_called.should == :animating
    wait 0.1 {
      @after_called.should == true
    }
  end

  it 'should animate if duration is 0 and delay > 0' do
    @after_called = false
    UIView.animate(after:->{ @after_called = true }, duration: 0.0, delay: 0.1) {
      @view.frame = [[0, 0], [0, 0]]
      @after_called = :animating
    }
    @after_called.should == :animating
    wait 0.1 {
      @after_called.should == true
    }
  end

  it 'should not animate if duration is 0' do
    @after_called = false
    UIView.animate(after:->{ @after_called = true }, duration: 0.0) {
      @view.frame = [[0, 0], [0, 0]]
      @after_called = :animating
    }
    @after_called.should == true
  end

  it 'should not animate if duration is 0, and after: is not required' do
    @after_called = false
    UIView.animate(duration: 0.0) {
      @view.frame = [[0, 0], [0, 0]]
      @after_called = true
    }
    @after_called.should == true
  end

end
