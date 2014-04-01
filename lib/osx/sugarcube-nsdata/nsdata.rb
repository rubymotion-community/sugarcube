class NSData

  # @return [NSImage]
  def nsimage
    return NSImage.alloc.initWithData(self)
  end

end
