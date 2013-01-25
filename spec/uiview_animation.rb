describe "UIView animation methods" do
  before do
    @view = UIView.alloc.initWithFrame([[1,2],[3,4]])
  end

  it 'should delta_to x:1 y:2' do
    @view.delta_to([1,2]).frame.should == CGRectMake(2,4,3,4)
  end
  
end
