class NSURL

  def nsdata
    NSData.dataWithContentsOfURL(self)
  end

end
