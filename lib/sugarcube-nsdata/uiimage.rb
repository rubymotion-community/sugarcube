class UIImage

  # @return [NSData] an NSData object in PNG format
  def nsdata
    UIImagePNGRepresentation(self)
  end

end
