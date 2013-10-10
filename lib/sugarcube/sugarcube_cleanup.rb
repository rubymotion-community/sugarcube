class UIViewController

  def sugarcube_cleanup
    super
    self.view.sugarcube_cleanup
    self.childViewControllers.each do |subctlr|
      subctlr.sugarcube_cleanup
    end
  end

end


class UIResponder

  class << self

    def sugarcube_cleanup(&block)
      @sugarcube_cleanup ||= []
      return @sugarcube_cleanup unless block
      @sugarcube_cleanup << block
      return nil
    end

  end

  def sugarcube_cleanup
    self.class.ancestors.each do |klass|
      next unless klass.respond_to?(:sugarcube_cleanup)
      klass.sugarcube_cleanup.each do |block|
        self.instance_eval(&block)
      end
      break if klass == UIResponder
    end
  end

end


class UIView

  def sugarcube_cleanup
    super
    self.subviews.each do |subview|
      subview.sugarcube_cleanup
    end
  end

end
