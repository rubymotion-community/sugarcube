class NSURL

  def open
    UIApplication.sharedApplication.openURL(self)
  end

  def can_open?
    UIApplication.sharedApplication.canOpenURL(self)
  end

  def nsurl
    self
  end

  def nsurlrequest
    NSURLRequest.requestWithURL(self)
  end

  def nsmutableurlrequest
    NSMutableURLRequest.alloc.initWithURL(self)
  end

end
