class UIViewController

  def to_s
    ret = super
    if self.presentingViewController
      ret += " presented by #{self.presentingViewController.to_s}"
    end
    ret
  end

end
