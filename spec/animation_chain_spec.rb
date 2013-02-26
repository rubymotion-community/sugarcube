describe "SugarCube::AnimationChain" do
  tests SugarCube::AnimationChainController

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

  it "should support looping" do
    SugarCube::AnimationChain.chains.length.should == 0
    @variable_a = 0
    @num_loops = 2
    UIView.animation_chain(duration:0.1){
      @variable_a += 1
    }.loop(@num_loops)
    SugarCube::AnimationChain.chains.length.should == 1

    wait 0.3 {
      @variable_a.should == @num_loops
      SugarCube::AnimationChain.chains.length.should == 0
    }
  end

  it "should support stopping" do
    SugarCube::AnimationChain.chains.length.should == 0
    @variable_a = 0
    @num_loops = 0
    @chain = UIView.animation_chain(duration:0.1){
      @variable_a += 1
      f = controller.view.frame
      f.origin.x -= 20
      controller.view.frame = f
    }.loop
    SugarCube::AnimationChain.chains.length.should == 1

    wait 0.2 {
      SugarCube::AnimationChain.chains.length.should == 1
      @variable_a.should > 1
      @chain.stop
    }

    wait 0.4 {
      SugarCube::AnimationChain.chains.length.should == 0
      @variable_a.should < 4
    }
  end

  it "should support aborting" do
    SugarCube::AnimationChain.chains.length.should == 0
    @variable_a = 0
    @num_loops = 0
    @chain = UIView.animation_chain(duration:0.1){
      @variable_a += 1
      f = controller.view.frame
      f.origin.x -= 20
      controller.view.frame = f
    }.and_then {
      @variable_a += 1
      f = controller.view.frame
      f.origin.x += 20
      controller.view.frame = f
    }.loop
    SugarCube::AnimationChain.chains.length.should == 1

    wait 0.21 {
      SugarCube::AnimationChain.chains.length.should == 1
      @variable_a.should == 2
    }

    wait 0.31 {
      @chain.abort
      @num_loops = @variable_a
    }
    wait 0.51 {
      SugarCube::AnimationChain.chains.length.should == 0
      @variable_a.should == @num_loops
    }
  end

end
