class NSData

  # converts an NSData instance into a base64 string.
  # @todo Support NSDataBase64EncodingOptions options - easy to add, but I want
  # to add specs, too, and a hash format (e.g. line_length: 64 =>
  # NSDataBase64Encoding64CharacterLineLength).
  def to_base64
    self.base64EncodedStringWithOptions(0)
  end

  # factory method to convert a base64 string into NSData.
  def self.from_base64(base64_data)
    NSData.alloc.initWithBase64EncodedData(base64_data, options: 0)
  end

end
