class NSData

  # converts NSData into an NSString using any encoding, default is UTF8
  # @return [NSString]
  def nsstring(encoding=nil)
    if encoding
      NSString.stringWithCString(self.bytes, encoding:encoding)
    else
      NSString.stringWithUTF8String(self.bytes)
    end
  end

  # @return [UIImage]
  def uiimage(scale=nil)
    if scale
      UIImage.imageWithData(self, scale:scale)
    else
      UIImage.imageWithData(self)
    end
  end

end
