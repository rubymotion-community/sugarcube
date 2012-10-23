class UIActivityIndicatorView
  class << self

    def large
      self.alloc.initWithActivityIndicatorStyle(:large.uiactivityindicatorstyle)
    end

    def white
      self.alloc.initWithActivityIndicatorStyle(:white.uiactivityindicatorstyle)
    end

    def gray
      self.alloc.initWithActivityIndicatorStyle(:gray.uiactivityindicatorstyle)
    end
  end

end
