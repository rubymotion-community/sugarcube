

class UINavigationController

  def push(view_controller)
    self.pushViewController(view_controller, animated: true)
    self
  end

  def <<(view_controller)
    self.pushViewController(view_controller, animated: true)
    self
  end

  def pop
    self.popViewController
  end

  def !(to_view=nil)
    if to_view
      self.popToViewController(to_view, animated: true)
    else
      self.popToRootViewControllerAnimated(true)
    end
  end

end
