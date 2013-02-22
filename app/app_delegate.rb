include SugarCube::Adjust
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


class MyController < UIViewController

  def loadView
    super.tap do
      @label = 'Hi!'.uilabel
      @label.center = self.view.center
      @label.textColor = :white.uicolor
      self.view << @label
    end
  end

end
