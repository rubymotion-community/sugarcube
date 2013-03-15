describe 'UIViewController' do

  it 'should have `push` method' do
    controller = UIViewController.new
    controller.push UIViewController.new
    controller.childViewControllers.length.should == 1
    controller.push UIViewController.new
    controller.childViewControllers.length.should == 2
  end

  it 'should have `<<` method' do
    controller = UIViewController.new
    controller << UIViewController.new
    controller.childViewControllers.length.should == 1
    controller << UIViewController.new
    controller.childViewControllers.length.should == 2
  end

end


describe 'UINavigationViewController' do

  before do
    @root_controller = UIViewController.new
    second_controller = UIViewController.new
    @target_controller = UIViewController.new
    fourth_controller = UIViewController.new
    @nav_controller = UINavigationController.alloc.initWithRootViewController(@root_controller)
    @nav_controller.pushViewController(second_controller, animated: false)
    @nav_controller.pushViewController(@target_controller, animated: false)
    @nav_controller.pushViewController(fourth_controller, animated: false)
  end

  it 'should have `push` method' do
    test_controller = UIViewController.new
    length = @nav_controller.viewControllers.length
    @nav_controller.push(test_controller)
    @nav_controller.viewControllers.length.should == length + 1
  end

  it 'should have `<<` method' do
    test_controller = UIViewController.new
    length = @nav_controller.viewControllers.length
    @nav_controller << test_controller
    @nav_controller.viewControllers.length.should == length + 1
  end

  it 'should have `pop()` method' do
    length = @nav_controller.viewControllers.length
    @nav_controller.pop
    @nav_controller.viewControllers.length.should == length - 1
  end

  it 'should have `pop(:root)` method' do
    @nav_controller.pop :root
    @nav_controller.viewControllers.length.should == 1
    @nav_controller.visibleViewController.should == @root_controller
  end

  it 'should have `pop(@target_controller)` method' do
    @nav_controller.pop @target_controller
    @nav_controller.visibleViewController.should == @target_controller
  end

end


describe 'UITabBarController' do

  it 'should have `push` method' do
    controller = UITabBarController.new
    controller.push UIViewController.new
    controller.viewControllers.length.should == 1
    controller.push UIViewController.new
    controller.viewControllers.length.should == 2
  end

  it 'should have `<<` method' do
    controller = UITabBarController.new
    controller << UIViewController.new
    controller.viewControllers.length.should == 1
    controller << UIViewController.new
    controller.viewControllers.length.should == 2
  end

end
