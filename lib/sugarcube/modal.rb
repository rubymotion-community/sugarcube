module SugarCube
  module Modal
    module_function
    def present_modal(view_ctlr, &block)
      UIApplication.sharedApplication.keyWindow.rootViewController.presentViewController(view_ctlr, animated:true, completion:block)
    end

    def dismiss_modal(&block)
      UIApplication.sharedApplication.keyWindow.rootViewController.dismissViewControllerAnimated(true, completion:block)
    end
  end
end
