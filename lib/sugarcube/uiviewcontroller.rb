

class UINavigationController

  def push(view_controller)
    self.pushViewController(view_controller)
  end

  def pop
    self.popViewController
  end

end
