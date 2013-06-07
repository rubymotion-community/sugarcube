class UIButton
  class << self
    def custom
      self.buttonWithType(UIButtonTypeCustom)
    end
    def rounded
      if self != UIButton
        raise "Custom subclasses of UIButton most be created using UIButton.custom"
      end
      self.buttonWithType(UIButtonTypeRoundedRect)
    end
    def rounded_rect
      if self != UIButton
        raise "Custom subclasses of UIButton most be created using UIButton.custom"
      end
      self.buttonWithType(UIButtonTypeRoundedRect)
    end
    def detail
      if self != UIButton
        raise "Custom subclasses of UIButton most be created using UIButton.custom"
      end
      self.buttonWithType(UIButtonTypeDetailDisclosure)
    end
    def detail_disclosure
      if self != UIButton
        raise "Custom subclasses of UIButton most be created using UIButton.custom"
      end
      self.buttonWithType(UIButtonTypeDetailDisclosure)
    end
    def info
      if self != UIButton
        raise "Custom subclasses of UIButton most be created using UIButton.custom"
      end
      self.buttonWithType(UIButtonTypeInfoLight)
    end
    def info_light
      if self != UIButton
        raise "Custom subclasses of UIButton most be created using UIButton.custom"
      end
      self.buttonWithType(UIButtonTypeInfoLight)
    end
    def info_dark
      if self != UIButton
        raise "Custom subclasses of UIButton most be created using UIButton.custom"
      end
      self.buttonWithType(UIButtonTypeInfoDark)
    end
    def contact
      if self != UIButton
        raise "Custom subclasses of UIButton most be created using UIButton.custom"
      end
      self.buttonWithType(UIButtonTypeContactAdd)
    end
    def contact_add
      if self != UIButton
        raise "Custom subclasses of UIButton most be created using UIButton.custom"
      end
      self.buttonWithType(UIButtonTypeContactAdd)
    end
  end
end
