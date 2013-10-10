class UIViewController

  def sugarcube_cleanup(target=nil)
    if target
      target.sugarcube_cleanup
      target.subviews.each do |subview|
        sugarcube_cleanup(subview)
      end
    else
      sugarcube_cleanup(self.view)
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
      self.class.sugarcube_cleanup.each do |block|
        self.instance_eval(&block)
      end
    end
  end

end
