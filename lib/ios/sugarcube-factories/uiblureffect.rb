class UIBlurEffect
  class << self
    def dark
      self.effectWithStyle(UIBlurEffectStyleDark)
    end

    def light
      self.effectWithStyle(UIBlurEffectStyleLight)
    end

    def extra_light
      self.effectWithStyle(UIBlurEffectStyleExtraLight)
    end
  end
end
