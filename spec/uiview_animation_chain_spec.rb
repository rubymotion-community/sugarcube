describe "SugarCube::AnimationChain" do
  tests SugarCube::AnimationChainController

  it "should have a view" do
    controller.view.should != nil
  end

  it "should support chains" do
    SugarCube::AnimationChain.chains.length.should == 0
    @variable_a = nil
    @variable_b = nil
    UIView.animation_chain(duration:0.1){
      @variable_a = 'a'
      f = controller.view.frame
      f.origin.x -= 20
      controller.view.frame = f
    }.and_then(duration: 0.1){
      @variable_b = 'b'
      f = controller.view.frame
      f.origin.x += 20
      controller.view.frame = f
    }.start

    SugarCube::AnimationChain.chains.length.should == 1

    wait 0.05 {
      @variable_a.should == 'a'
      @variable_b.should == nil
      SugarCube::AnimationChain.chains.length.should == 1
    }
    wait 0.15 {
      @variable_a.should == 'a'
      @variable_b.should == 'b'
      SugarCube::AnimationChain.chains.length.should == 1
    }
    wait 0.25 {
      SugarCube::AnimationChain.chains.length.should == 0
    }
  end

  it "should support multiple chains" do
    SugarCube::AnimationChain.chains.length.should == 0
    @variable_a = nil
    @variable_b = nil
    UIView.animation_chain(duration:0.1, delay:0.1){
      @variable_a = 'a'
    }.start
    UIView.animation_chain(duration:0.1, delay:0.1){
      @variable_b = 'b'
    }.start
    SugarCube::AnimationChain.chains.length.should == 2

    wait 0.3 {
      @variable_a.should == 'a'
      @variable_b.should == 'b'
      SugarCube::AnimationChain.chains.length.should == 0
    }
  end

  it "should support << syntax" do
    SugarCube::AnimationChain.chains.length.should == 0
    @variable_a = nil
    @variable_b = nil
    chain = UIView.animation_chain
    chain << proc { @variable_a = 'a' } << proc { @variable_b = 'b' }
    chain.start
    SugarCube::AnimationChain.chains.length.should == 1

    wait 0.3 {
      @variable_a.should == 'a'
      @variable_b.should == 'b'
      SugarCube::AnimationChain.chains.length.should == 0
    }
  end

end
