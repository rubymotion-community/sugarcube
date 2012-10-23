class UIViewController

  def push(view_controller)
    self.addChildViewController(view_controller)
    self
  end
  alias << push

end


class UINavigationController

  def push(view_controller)
    self.pushViewController(view_controller, animated: true)
    self
  end
  alias << push

  def pop(to_view=nil)
    if to_view
      self.popToViewController(to_view, animated: true)
    else
      self.popViewControllerAnimated(true)
    end
  end

end


class UITabBarController

  def push(view_controller)
    view_controllers = [] + self.viewControllers
    view_controllers << view_controller
    self.setViewControllers(view_controllers, animated: true)
    self
  end
  alias << push

end
