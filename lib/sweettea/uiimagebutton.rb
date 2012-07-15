
class UIImageButton < UIButton

  def self.new
    UIButton.buttonWithType(UIButtonTypeCustom)
  end

end

class UIFullScreenView < UIView

  def didMoveToSuperview
    super
    self.frame = self.superview.frame
  end

end
