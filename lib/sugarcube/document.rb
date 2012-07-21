class NSString

  def document
    @docs ||= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0]
    @docs.stringByAppendingPathComponent(self)
  end

  def exists?
    NSFileManager.defaultManager.fileExistsAtPath(self)
  end

end
