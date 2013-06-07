class UIImage

  # @return [UIImageView]
  def uiimageview
    UIImageView.alloc.initWithImage(self)
  end

end
