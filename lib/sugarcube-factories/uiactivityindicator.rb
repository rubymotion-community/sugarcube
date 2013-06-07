class UIActivityIndicatorView
  class << self

    def large
      self.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleWhiteLarge)
    end

    def white
      self.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleWhite)
    end

    def gray
      self.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleGray)
    end
  end

end
