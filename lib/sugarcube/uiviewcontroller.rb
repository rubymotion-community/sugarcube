class UINavigationController

  def push(view_controller)
    self.pushViewController(view_controller, animated: true)
    self
  end

  def <<(view_controller)
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

  def <<(view_controller)
    view_controllers = [] + self.viewControllers
    view_controllers << view_controller
    self.setViewControllers(view_controllers, animated: true)
    self
  end

end
