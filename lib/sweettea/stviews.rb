class UIButton
  class << self
    def custom
      UIButton.buttonWithType(:custom.uibuttontype)
    end
    def rounded
      UIButton.buttonWithType(:rounded.uibuttontype)
    end
    def rounded_rect
      UIButton.buttonWithType(:rounded_rect.uibuttontype)
    end
    def detail
      UIButton.buttonWithType(:detail.uibuttontype)
    end
    def detail_disclosure
      UIButton.buttonWithType(:detail_disclosure.uibuttontype)
    end
    def info
      UIButton.buttonWithType(:info.uibuttontype)
    end
    def info_light
      UIButton.buttonWithType(:info_light.uibuttontype)
    end
    def info_dark
      UIButton.buttonWithType(:info_dark.uibuttontype)
    end
    def contact
      UIButton.buttonWithType(:contact.uibuttontype)
    end
    def contact_add
      UIButton.buttonWithType(:contact_add.uibuttontype)
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
