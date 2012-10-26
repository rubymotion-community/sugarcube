class UIViewController

  def push(view_controller)
    self.addChildViewController(view_controller)
    self
  end

  # `alias << push` won't work. it doesn't "respect" subclasses overriding the
  # `push` method.
  def <<(view_controller)
    push view_controller
  end

end


class UINavigationController

  def push(view_controller)
    self.pushViewController(view_controller, animated: true)
    self
  end

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

end
