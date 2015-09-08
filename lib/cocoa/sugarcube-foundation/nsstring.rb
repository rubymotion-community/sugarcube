class NSString

  # @return [NSURL]
  def nsurl
    @url ||= NSURL.alloc.initWithString(self)
  end

  # @return [NSURL]
  def fileurl
    @fileurl ||= NSURL.fileURLWithPath(self)
  end

  def escape_url
    CFURLCreateStringByAddingPercentEscapes(
            nil,
            self,
            nil,
            "!*'();:@&=+$,/?%#[]",
            CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)
            )
  end

  def unescape_url
    self.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
  end

  def remove_accents
    # removes diacritics by using a lossy conversion
    ascii = self.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)

    # turn it back into a string
    return NSString.alloc.initWithData(ascii, encoding: NSASCIIStringEncoding)
  end

end
