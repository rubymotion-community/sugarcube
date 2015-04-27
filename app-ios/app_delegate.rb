include SugarCube::CoreGraphics


class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    return true if RUBYMOTION_ENV == 'test'

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    ctlr = UINavigationController.new
    ctlr << UIViewController.new.tap { |c| c.title = "foo" }
    ctlr << UIViewController.new.tap { |c| c.title = "bar" }
    ctlr << UIViewController.new.tap { |c| c.title = "baz" }
    @window.rootViewController = ctlr

    @window.makeKeyAndVisible
  end
end
