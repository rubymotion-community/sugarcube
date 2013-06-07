class UIImage
  def uiimage ; self ; end

  # @return [UIImageView]
  def uiimageview
    UIImageView.alloc.initWithImage(self)
  end

end
