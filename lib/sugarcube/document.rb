class NSString

  def document
    @@docs ||= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0]
    return self if self.hasPrefix(@@docs)

    @@docs.stringByAppendingPathComponent(self)
  end

  def exists?
    NSFileManager.defaultManager.fileExistsAtPath(self.document)
  end

end
