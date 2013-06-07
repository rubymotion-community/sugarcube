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
    CFURLCreateStringByReplacingPercentEscapes(
            nil,
            self,
            ""
            )
  end

end
