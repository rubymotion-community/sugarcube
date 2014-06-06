class NSString

  # This method will be removed in iOS 9
  def document
    message = 'Warning: SugarCube\'s String#document method has been deprecated in favor of String#document_path'
    if defined?(SugarCube::Legacy)
      SugarCube::Legacy.log(message)
    else
      NSLog(message)
    end
    self.document_path
  end

  # This method will be removed in iOS 9
  def cache
    message = 'Warning: SugarCube\'s String#cache method has been deprecated in favor of String#cache_path'
    if defined?(SugarCube::Legacy)
      SugarCube::Legacy.log(message)
    else
      NSLog(message)
    end
    self.cache_path
  end

  # This method will be removed in iOS 9
  def app_support
    message = 'Warning: SugarCube\'s String#app_support method has been deprecated in favor of String#app_support_path'
    if defined?(SugarCube::Legacy)
      SugarCube::Legacy.log(message)
    else
      NSLog(message)
    end
    self.app_support_path
  end

  # This method will be removed in iOS 9
  def temporary
    message = 'Warning: SugarCube\'s String#temporary method has been deprecated in favor of String#temporary_path'
    if defined?(SugarCube::Legacy)
      SugarCube::Legacy.log(message)
    else
      NSLog(message)
    end
    self.temporary_path
  end

  # This method will be removed in iOS 9
  def exists?
    message = 'Warning: SugarCube\'s String#exists? method has been deprecated in favor of String#file_exists?'
    if defined?(SugarCube::Legacy)
      SugarCube::Legacy.log(message)
    else
      NSLog(message)
    end
    self.file_exists?
  end

  # This method will be removed in iOS 9
  def remove!
    message = 'Warning: SugarCube\'s String#remove! method has been deprecated in favor of String#remove_file!'
    if defined?(SugarCube::Legacy)
      SugarCube::Legacy.log(message)
    else
      NSLog(message)
    end
    self.remove_file!
  end

  # This method will be removed in iOS 9
  def resource
    message = 'Warning: SugarCube\'s String#resource method has been deprecated in favor of String#resource_path'
    if defined?(SugarCube::Legacy)
      SugarCube::Legacy.log(message)
    else
      NSLog(message)
    end
    self.resource_path
  end

end
