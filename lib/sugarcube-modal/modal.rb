module SugarCube
  module Modal
    module_function
    def present_modal(view_ctlr, options={}, &block)
      target = options[:target] || UIApplication.sharedApplication.keyWindow.rootViewController
      animated = options.fetch(:animated, true)
      target.presentViewController(view_ctlr, animated:animated, completion:block)
    end

    def present_modal_in_nav(view_ctlr, options={}, &block)
      ctlr = UINavigationController.alloc.initWithRootViewController(view_ctlr)
      ctlr.modalTransitionStyle = UIModalTransitionStyleCoverVertical

      SugarCube::Modal.present_modal(ctlr, options, &block)
      ctlr
    end

    def dismiss_modal(options={}, &block)
      target = options.fetch(:target, UIApplication.sharedApplication.keyWindow.rootViewController)
      animated = options.fetch(:animated, true)
      target.dismissViewControllerAnimated(animated, completion:block)
    end
  end
end


class UIViewController

  def present_modal(view_ctlr, options={}, &block)
    options = options.merge(target: self)
    SugarCube::Modal.present_modal(view_ctlr, options, &block)
  end

  def present_modal_in_nav(view_ctlr, options={}, &block)
    options = options.merge(target: self)
    SugarCube::Modal.present_modal_in_nav(view_ctlr, options, &block)
  end

  def dismiss_modal(options={}, &block)
    options = options.merge(target: self)
    SugarCube::Modal.dismiss_modal(options, &block)
  end

end
