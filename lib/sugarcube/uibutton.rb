class UIButton
  class << self
    def custom
      self.buttonWithType(:custom.uibuttontype)
    end
    def rounded
      self.buttonWithType(:rounded.uibuttontype)
    end
    def rounded_rect
      self.buttonWithType(:rounded_rect.uibuttontype)
    end
    def detail
      self.buttonWithType(:detail.uibuttontype)
    end
    def detail_disclosure
      self.buttonWithType(:detail_disclosure.uibuttontype)
    end
    def info
      self.buttonWithType(:info.uibuttontype)
    end
    def info_light
      self.buttonWithType(:info_light.uibuttontype)
    end
    def info_dark
      self.buttonWithType(:info_dark.uibuttontype)
    end
    def contact
      self.buttonWithType(:contact.uibuttontype)
    end
    def contact_add
      self.buttonWithType(:contact_add.uibuttontype)
    end
  end
end
