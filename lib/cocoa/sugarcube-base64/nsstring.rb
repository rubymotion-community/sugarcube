class NSString

  def to_base64(enc=NSUTF8StringEncoding)
    encoded = self.dataUsingEncoding(enc)
    encoded.to_base64
  end

  def self.from_base64(base64_str, enc=NSUTF8StringEncoding)
    data = NSData.from_base64(base64_str.dataUsingEncoding(NSASCIIStringEncoding))
    NSString.alloc.initWithData(data, encoding:enc)
  end

end
