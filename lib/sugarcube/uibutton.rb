class UIButton
  class << self
    def custom
      self.buttonWithType(:custom.uibuttontype)
    end
    def rounded
      if self != UIButton
        raise "Custom subclasses of UIButton most be created using UIButton.custom"
      end
      self.buttonWithType(:rounded.uibuttontype)
    end
    def rounded_rect
      if self != UIButton
        raise "Custom subclasses of UIButton most be created using UIButton.custom"
      end
      self.buttonWithType(:rounded_rect.uibuttontype)
    end
    def detail
      if self != UIButton
        raise "Custom subclasses of UIButton most be created using UIButton.custom"
      end
      self.buttonWithType(:detail.uibuttontype)
    end
    def detail_disclosure
      if self != UIButton
        raise "Custom subclasses of UIButton most be created using UIButton.custom"
      end
      self.buttonWithType(:detail_disclosure.uibuttontype)
    end
    def info
      if self != UIButton
        raise "Custom subclasses of UIButton most be created using UIButton.custom"
      end
      self.buttonWithType(:info.uibuttontype)
    end
    def info_light
      if self != UIButton
        raise "Custom subclasses of UIButton most be created using UIButton.custom"
      end
      self.buttonWithType(:info_light.uibuttontype)
    end
    def info_dark
      if self != UIButton
        raise "Custom subclasses of UIButton most be created using UIButton.custom"
      end
      self.buttonWithType(:info_dark.uibuttontype)
    end
    def contact
      if self != UIButton
        raise "Custom subclasses of UIButton most be created using UIButton.custom"
      end
      self.buttonWithType(:contact.uibuttontype)
    end
    def contact_add
      if self != UIButton
        raise "Custom subclasses of UIButton most be created using UIButton.custom"
      end
      self.buttonWithType(:contact_add.uibuttontype)
    end
  end
end
