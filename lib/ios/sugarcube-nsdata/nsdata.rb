class NSData

  # @return [UIImage]
  def uiimage(scale=nil)
    if scale
      return UIImage.imageWithData(self, scale:scale)
    else
      return UIImage.imageWithData(self)
    end
  end

end
