describe NSView do

  it 'should support <<' do
    view1 = NSView.new
    view2 = NSView.new
    view1 << view2
    view2.superview.should == view1
  end

  it 'should support unshift' do
    view1 = NSView.new
    view2 = NSView.new
    view1.unshift view2
    view2.superview.should == view1
  end

  it 'should support first_responder' do
    view1 = NSView.new
    view2 = NSTextField.new
    view1 << view2
    view2.becomeFirstResponder
    view1.first_responder.should == view2
  end

  describe "should convert bounds" do
    before do
      @view1 = NSView.alloc.initWithFrame([[0, 0], [100, 100]])
      @view2 = NSView.alloc.initWithFrame([[10, 5], [80, 90]])
      @view1 << @view2
      @view3 = NSView.alloc.initWithFrame([[10, 5], [60, 80]])
      @view2 << @view3
    end

    it "should convert_frame_to" do
      frame = @view3.convert_frame_to(@view1)
      frame.origin.x.should == 20
      frame.origin.y.should == 10
      frame.size.width.should == 60
      frame.size.height.should == 80
    end

    it "should convert_frame_from" do
      frame = @view1.convert_frame_from(@view3)
      frame.origin.x.should == 20
      frame.origin.y.should == 10
      frame.size.width.should == 60
      frame.size.height.should == 80
    end

    it "should convert_rect(to:)" do
      frame = @view3.convert_rect([[1, 2], [10, 20]], to: @view1)
      frame.origin.x.should == 21
      frame.origin.y.should == 12
      frame.size.width.should == 10
      frame.size.height.should == 20
    end

    it "should convert_rect(from:)" do
      frame = @view1.convert_rect([[1, 2], [10, 20]], from: @view3)
      frame.origin.x.should == 21
      frame.origin.y.should == 12
      frame.size.width.should == 10
      frame.size.height.should == 20
    end

  end

  describe "should convert point" do
    before do
      @view1 = NSView.alloc.initWithFrame([[0, 0], [100, 100]])
      @view2 = NSView.alloc.initWithFrame([[10, 5], [80, 90]])
      @view1 << @view2
      @view3 = NSView.alloc.initWithFrame([[10, 5], [60, 80]])
      @view2 << @view3
    end

    it "should convert_origin_to" do
      point = @view3.convert_origin_to(@view1)
      point.x.should == 20
      point.y.should == 10
    end

    it "should convert_origin_from" do
      point = @view1.convert_origin_from(@view3)
      point.x.should == 20
      point.y.should == 10
    end

    it "should convert_point(to:)" do
      point = @view3.convert_point([1, 2], to: @view1)
      point.x.should == 21
      point.y.should == 12
    end

    it "should convert_point(:from)" do
      point = @view1.convert_point([1, 2], from: @view3)
      point.x.should == 21
      point.y.should == 12
    end

  end

end