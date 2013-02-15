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
    current_angle =  Math.atan2(@view.transform.b, @view.transform.a)
    current_angle.should == angle
  end

  it 'should animate anything' do
    UIView.animate {
      @view.frame = [[0, 0], [0, 0]]
    }
    CGRectEqualToRect(@view.frame, [[0, 0], [0, 0]]).should == true
  end
end
