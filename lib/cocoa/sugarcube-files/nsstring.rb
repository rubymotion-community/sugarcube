class NSString

  def document_path
    @@sugarcube_docs ||= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0]
    return self if self.hasPrefix(@@sugarcube_docs)

    @@sugarcube_docs.stringByAppendingPathComponent(self)
  end

  def cache_path
    @@sugarcube_caches ||= NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true)[0]
    return self if self.hasPrefix(@@sugarcube_caches)

    @@sugarcube_caches.stringByAppendingPathComponent(self)
  end

  def app_support_path
    @@sugarcube_app_support ||= NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, true)[0]
    return self if self.hasPrefix(@@sugarcube_app_support)

    @@sugarcube_app_support.stringByAppendingPathComponent(self)
  end

  def temporary_path
    @@sugarcube_temporary ||= NSTemporaryDirectory()
    return self if self.hasPrefix(@@sugarcube_temporary)

    @@sugarcube_temporary.stringByAppendingPathComponent(self)
  end

  def file_exists?
    path = self.hasPrefix('/') ? self : self.document_path
    NSFileManager.defaultManager.fileExistsAtPath(path)
  end

  def remove_file!
    ptr = Pointer.new(:id)
    path = self.hasPrefix('/') ? self : self.document_path
    NSFileManager.defaultManager.removeItemAtPath(path, error:ptr)
    ptr[0]
  end

  def resource_path
    @@sugarcube_resources ||= NSBundle.mainBundle.resourcePath
    return self if self.hasPrefix(@@sugarcube_resources)

    @@sugarcube_resources.stringByAppendingPathComponent(self)
  end

  def resource_exists?
    self.resource_path.file_exists?
  end

  def resource_url
    a = self.split('.')
    ext = a.pop if a.size >= 2
    NSBundle.mainBundle.URLForResource(a.join("."), withExtension:ext)
  end

  def file_url
    NSURL.fileURLWithPath(self)
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
