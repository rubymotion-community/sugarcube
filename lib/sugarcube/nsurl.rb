class NSURL

  def open
    UIApplication.sharedApplication.openURL(NSURL.URLWithString(self))
  end

  def can_open?
    UIApplication.sharedApplication.canOpenURL(NSURL.URLWithString(self))
  end

end
