class NSData

  # converts NSData into an NSString using any encoding, default is UTF8
  # @return [NSString]
  def nsstring(encoding=nil)
    if encoding
      return NSString.stringWithCString(self.bytes, encoding:encoding)
    else

      return NSString.stringWithUTF8String(self)
    end
  end

  # @return [UIImage]
  def uiimage(scale=nil)
    if scale
      return UIImage.imageWithData(self, scale:scale)
    else
      return UIImage.imageWithData(self)
    end
  end

  def write(path_or_url, atomically=true)
    case path_or_url
    when NSURL
      self.writeToURL(path_or_url, atomically:atomically)
    when NSString
      self.writeToFile(path_or_url, atomically:atomically)
    else
      false
    end
  end
  
end
