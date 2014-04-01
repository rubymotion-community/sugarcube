class NSString

  # @return [NSData] NSData representation encoded using UTF8, or a specified
  #   encoding
  def nsdata(encoding=NSUTF8StringEncoding)
    dataUsingEncoding(encoding)
  end

end
