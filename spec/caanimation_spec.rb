describe CAAnimation do

  describe "should have `basic` animation" do

    it "should accept keypath" do
      animation = CAAnimation.basic('opacity')
      animation.keyPath.should == 'opacity'
    end

    it "should assign :to value" do
      animation = CAAnimation.basic('opacity', to: 0)
      animation.toValue.should == 0
    end

    it "should assign :from value" do
      animation = CAAnimation.basic('opacity', from: 1)
      animation.fromValue.should == 1
    end

    it "should assign :by value" do
      animation = CAAnimation.basic('opacity', by: -1)
      animation.byValue.should == -1
    end

  end

  describe "should have `keyframe` animation" do

    it "should accept keypath" do
      animation = CAAnimation.keyframe('opacity')
      animation.keyPath.should == 'opacity'
    end

    it "should assign :values" do
      animation = CAAnimation.keyframe('opacity', values: [0, 0.5, 1])
      animation.values.should == [0, 0.5, 1]
    end

    it "should assign :timing value" do
      animation = CAAnimation.keyframe('opacity', timing: KCAMediaTimingFunctionLinear)
      animation.timingFunction.should == CAMediaTimingFunction.functionWithName(KCAMediaTimingFunctionLinear)
    end

    it "should assign :by value" do
      animation = CAAnimation.keyframe('opacity', by: -1)
      animation.byValue.should == -1
    end

  end

  describe "should have `CALayer#basic_animation` helper" do
  end

  describe "should have `CALayer#keyframe_animation` helper" do
  end

end
