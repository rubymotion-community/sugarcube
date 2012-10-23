class NSURL

  def open
    NSUIApplication.sharedApplication.openURL(NSUrl.URLWithString(self))
  end

  def can_open?
    NSUIApplication.sharedApplication.canOpenURL(NSUrl.URLWithString(self))
  end

end
