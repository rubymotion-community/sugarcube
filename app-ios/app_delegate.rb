include SugarCube::CoreGraphics


class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    return true if RUBYMOTION_ENV == 'test'

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    ctlr = MyController.new
    @window.rootViewController = ctlr

    @window.makeKeyAndVisible
  end
end
