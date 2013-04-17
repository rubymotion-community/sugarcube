class NSURL

  def open
    UIApplication.sharedApplication.openURL(self)
  end

  def can_open?
    UIApplication.sharedApplication.canOpenURL(self)
  end

  def nsdata
    NSData.dataWithContentsOfURL(self)
  end

  def nsurlrequest
    NSURLRequest.requestWithURL(self)
  end

end
