class NSString

  # converts an NSString instance into a base64 string, using UTF8 encoding or
  # a user specified encoding.
  # @todo Support NSDataBase64EncodingOptions options - easy to add, but I want
  # to add specs, too, and a hash format (e.g. line_length: 64 =>
  # NSDataBase64Encoding64CharacterLineLength).
  def to_base64(enc=NSUTF8StringEncoding)
    encoded = self.dataUsingEncoding(enc)
    encoded.to_base64
  end

  # factory method to convert a base64 string into NSString, using UTF8 or a
  # user specified encoding.
  def self.from_base64(base64_str, enc=NSUTF8StringEncoding)
    data = NSData.from_base64(base64_str.dataUsingEncoding(NSASCIIStringEncoding))
    NSString.alloc.initWithData(data, encoding:enc)
  end

end
