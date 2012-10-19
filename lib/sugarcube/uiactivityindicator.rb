class UIActivityIndicatorView
  class << self

    def large
      UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(:large.uiactivityindicatorstyle)
    end

    def white
      UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(:white.uiactivityindicatorstyle)
    end

    def gray
      UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(:gray.uiactivityindicatorstyle)
    end
  end
end