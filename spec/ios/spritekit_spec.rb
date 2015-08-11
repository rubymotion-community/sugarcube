class SpriteKitGameController < UIViewController
  attr :scene

  def loadView
    self.view = SKView.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    # Create and configure the scene.
    @scene = SKScene.sceneWithSize(self.view.bounds.size)
    @scene.scaleMode = SKSceneScaleModeAspectFill

    # Present the scene.
    self.view.presentScene(@scene)
  end

end


describe 'SpriteKit' do
  tests SpriteKitGameController

  before do
    path = CGPathCreateWithRect([[0, 0], [10, 10]], nil)

    @node_a = SKShapeNode.shapeNodeWithPath(path, centered: true)
    @node_a.position = [100, 100]
    @node_a.name = 'parent'
    controller.scene.addChild(@node_a)

    @node_b = SKShapeNode.shapeNodeWithPath(path, centered: true)
    @node_b.position = [0, 20]
    @node_b.name = 'child'
    @node_c = SKShapeNode.shapeNodeWithPath(path, centered: true)
    @node_c.position = [20, 20]
    @node_c.name = 'child'
    @node_d = SKShapeNode.shapeNodeWithPath(path, centered: true)
    @node_d.position = [20, 0]
    @node_d.name = 'not a child!'
  end

  describe '<< method' do
    it 'should add child nodes' do
      @node_a << @node_b
      @node_a << @node_c
      @node_b.parent.should == @node_a
      @node_c.parent.should == @node_a
      @node_a.children.should == [@node_b, @node_c]
    end
  end

  describe 'run_action method' do
    it 'should run an action and then call the completion block' do
      @completed = false

      @node_a.run_action(SKAction.moveTo([1, 1], duration: 1)) do
        @completed = true
      end

      wait 2 do
        @completed.should == true
        @node_a.position.x.should == 1
        @node_a.position.y.should == 1
      end
    end
  end

  describe '[] and []= methods' do
    it 'should assign user data with []=' do
      @node_a['life'] = 100
      @node_a.userData['life'].should == 100
    end
    it 'should assign user data and convert symbols to strings' do
      @node_a[:life] = 100
      @node_a.userData['life'].should == 100
    end
    it 'should get user data with []' do
      @node_a['life'] = 100
      @node_a['life'].should == 100
    end
    it 'should get user data and convert symbols to strings' do
      @node_a[:life] = 100
      @node_a[:life].should == 100
    end
  end

  describe 'each_named method' do
    before do
      @node_a << @node_b
      @node_a << @node_c
      @node_a << @node_d
    end

    it 'should iterate over child nodes (arity: 1)' do
      @found_b = false
      @found_c = false
      @found_d = false
      @node_a.each_named('child') do |node|
        @found_b = true if node == @node_b
        @found_c = true if node == @node_c
        @found_d = true if node == @node_d
      end
      @found_b.should == true
      @found_c.should == true
      @found_d.should == false
    end

    it 'should iterate over child nodes and stop with stop-pointer (arity: 2)' do
      @found = 0
      @node_a.each_named('child') do |node, stop_ptr|
        @found += 1
        stop_ptr.assign(true)
      end
      @found.should == 1
    end
  end

end
