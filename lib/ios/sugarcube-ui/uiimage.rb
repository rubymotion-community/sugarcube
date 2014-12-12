class UIImage
  def uiimage ; self ; end

  # @return [UIImageView]
  def uiimageview
    UIImageView.alloc.initWithImage(self)
  end

  def width
    self.size.width
  end

  def height
    self.size.height
  end

end
