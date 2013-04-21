class NSData

  def to_base64
    self.base64EncodedStringWithOptions(0)
  end

  def self.from_base64(base64_data)
    NSData.alloc.initWithBase64EncodedData(base64_data, options: 0)
  end

end
