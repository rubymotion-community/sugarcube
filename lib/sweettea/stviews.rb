
class STImageButton < UIButton

  def self.new
    UIButton.buttonWithType(UIButtonTypeCustom)
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
      v = UIContainerImageView.imageNamed(name)
    else
      v = self.alloc.initWithFrame([[0, 0], [0, 0]])
    end
    v.userInteractionEnabled = true
    v
  end

end
