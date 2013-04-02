class NSString

  def document
    @@sugarcube_docs ||= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0]
    return self if self.hasPrefix(@@sugarcube_docs)

    @@sugarcube_docs.stringByAppendingPathComponent(self)
  end
  
  def cache
    @@sugarcube_caches ||= NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true)[0]
    return self if self.hasPrefix(@@sugarcube_caches)

    @@sugarcube_caches.stringByAppendingPathComponent(self)
  end

  def exists?
    path = self.hasPrefix('/') ? self : self.document
    NSFileManager.defaultManager.fileExistsAtPath(path)
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

  # It's convenient to store a property which is dependent on an environment to
  # Info.plist. For instance, to use a different server between development and
  # release versions.
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
  #
  # You can easily get this value at run time like this:
  # <code>
  # 'VerifyURL'.info_plist
  # </code>
  def info_plist
      NSBundle.mainBundle.infoDictionary.valueForKey self
  end

end
