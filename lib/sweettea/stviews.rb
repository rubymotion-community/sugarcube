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


class UITableView
  class << self
    def plain
      UITableView.alloc.initWithFrame([[0, 0], [320, 480]], style: :plain.uitableviewstyle)
    end
    def grouped
      UITableView.alloc.initWithFrame([[0, 0], [320, 480]], style: :grouped.uitableviewstyle)
    end
  end
end



class STFullScreenView < UIView

  def didMoveToSuperview
    super
    self.frame = self.superview.frame
  end

end


class STInteractiveImageView < UIImageView

  def self.new(name=nil)
    if name
      v = STInteractiveImageView.imageNamed(name)
    else
      v = self.alloc.initWithFrame([[0, 0], [0, 0]])
    end
    v.userInteractionEnabled = true
    v
  end

end
