module SugarCube
  module Modal
    module_function
    def present_modal(view_ctlr, target=nil, &block)
      target ||= UIApplication.sharedApplication.keyWindow.rootViewController
      target.presentViewController(view_ctlr, animated:true, completion:block)
    end

    def present_modal_in_nav(view_ctlr, target=nil, &block)
      ctlr = UINavigationController.alloc.initWithRootViewController(view_ctlr)
      ctlr.modalTransitionStyle = UIModalTransitionStyleCoverVertical

      SugarCube::Modal.present_modal(ctlr, target, &block)
      ctlr
    end

    def dismiss_modal(target=nil, &block)
      target ||= UIApplication.sharedApplication.keyWindow.rootViewController
      target.dismissViewControllerAnimated(true, completion:block)
    end
  end
end


class UIViewController

  def present_modal(view_ctlr, &block)
    SugarCube::Modal.present_modal(view_ctlr, self, &block)
  end

  def present_modal_in_nav(view_ctlr, &block)
    SugarCube::Modal.present_modal_in_nav(view_ctlr, self, &block)
  end

  def dismiss_modal(view_ctlr, &block)
    SugarCube::Modal.dismiss_modal(view_ctlr, self, &block)
  end

end
