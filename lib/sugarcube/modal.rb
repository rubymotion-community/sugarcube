module SugarCube
  module Modal
    module_function
    def present_modal(view_ctlr, &block)
      UIApplication.sharedApplication.keyWindow.rootViewController.presentViewController(view_ctlr, animated:true, completion:block)
    end

    def present_modal_in_nav(view_ctlr, &block)
      ctlr = UINavigationController.alloc.initWithRootViewController(view_ctlr)
      ctlr.modalTransitionStyle = UIModalTransitionStyleCoverVertical

      SugarCube::Modal.present_modal(ctlr, &block)
      ctlr
    end

    def dismiss_modal(&block)
      UIApplication.sharedApplication.keyWindow.rootViewController.dismissViewControllerAnimated(true, completion:block)
    end
  end
end
