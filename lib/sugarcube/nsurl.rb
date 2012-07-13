class NSURL

  def open
    NSUIApplication.sharedApplication.openURL(NSUrl.URLWithString(self))
  end

end
