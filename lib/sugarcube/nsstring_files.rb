class NSString

  def document
    @@sugarcube_docs ||= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0]
    return self if self.hasPrefix(@@sugarcube_docs)

    @@sugarcube_docs.stringByAppendingPathComponent(self)
  end

  def exists?
    NSFileManager.defaultManager.fileExistsAtPath(self.document)
  end

  def remove!
    ptr = Pointer.new(:id)
    NSFileManager.defaultManager.removeItemAtPath(self.document, error:ptr)
    ptr[0]
  end

  def resource
    @@sugarcube_resources ||= NSBundle.mainBundle.resourcePath
    return self if self.hasPrefix(@@sugarcube_resources)

    @@sugarcube_resources.stringByAppendingPathComponent(self)
  end

  def resource_exists?
    NSFileManager.defaultManager.fileExistsAtPath(self.resource)
  end
  
  def resource_url
    a = self.split(".")
    ext = a.pop if a.size >= 2
    NSBundle.mainBundle.URLForResource(a.join("."), withExtension:ext)
  end

  # It's convinient to store a property which dependent on an environment to Info.plist.
  # i.e)
  # IAP verify server is different between a development and a release environment.
  #
  # In Rakefile
  # <code>
  # app.release do
  #   app.info_plist['VerifyURL'] = "https://buy.itunes.apple.com/verifyReceipt"
  # end
  # app.development do
  #   app.info_plist['VerifyURL'] = "https://sandbox.itunes.apple.com/verifyReceipt"
  # end
  # </code>
  # You can easily get a url of verify server at your environment like this.
  # <code>
  # 'VerifyURL'.info_plist
  # </code>
  def info_plist
      NSBundle.mainBundle.infoDictionary.valueForKey self
  end

end
