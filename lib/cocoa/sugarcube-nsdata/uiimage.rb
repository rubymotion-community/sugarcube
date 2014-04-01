class UIImage

  # @return [NSData] an NSData object in PNG or JPG format
  def nsdata(format=:png, compression=0.9)
    case format
    when :png, :PNG
      UIImagePNGRepresentation(self)
    when :jpg, :JPG
      UIImageJPEGRepresentation(self, compression)
    end
  end

end
