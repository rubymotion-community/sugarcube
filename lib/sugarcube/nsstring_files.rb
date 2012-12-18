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

end
