class NSString

  # @return [NSURL]
  def nsurl(baseURL=nil)
    @url ||= begin
      baseURL.nil? ? NSURL.alloc.initWithString(self) : NSURL.alloc.initWithString(self, relativeToURL: baseURL)
    end
  end

  # @return [NSURL]
  def fileurl(baseURL=nil)
    @fileurl ||= begin
      baseURL.nil? ? NSURL.fileURLWithPath(self) : NSURL.fileURLWithPath(self, relativeToURL: baseURL)
    end
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
