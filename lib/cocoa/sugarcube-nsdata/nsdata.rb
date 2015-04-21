class NSData

  # converts NSData into an NSString using any encoding, default is UTF8
  # @return [NSString]
  def nsstring(encoding=NSUTF8StringEncoding)
    return NSString.alloc.initWithData(self, encoding: encoding)
  end

  def write_to(path_or_url, atomically=true)
    case path_or_url
    when NSURL
      self.writeToURL(path_or_url, atomically: atomically)
    when NSString
      self.writeToFile(path_or_url, atomically: atomically)
    else
      false
    end
  end

end
