class NSString

  # This method will be removed in iOS 9
  def document
    SugarCube.log('Warning: SugarCube\'s String#document method has been deprecated in favor of String#document_path')
    self.document_path
  end

  # This method will be removed in iOS 9
  def cache
    SugarCube.log('Warning: SugarCube\'s String#cache method has been deprecated in favor of String#cache_path')
    self.cache_path
  end

  # This method will be removed in iOS 9
  def app_support
    SugarCube.log('Warning: SugarCube\'s String#app_support method has been deprecated in favor of String#app_support_path')
    self.app_support_path
  end

  # This method will be removed in iOS 9
  def temporary
    SugarCube.log('Warning: SugarCube\'s String#temporary method has been deprecated in favor of String#temporary_path')
    self.temporary_path
  end

  # This method will be removed in iOS 9
  def exists?
    SugarCube.log('Warning: SugarCube\'s String#exists? method has been deprecated in favor of String#file_exists?')
    self.file_exists?
  end

  # This method will be removed in iOS 9
  def remove!
    SugarCube.log('Warning: SugarCube\'s String#remove! method has been deprecated in favor of String#remove_file!')
    self.remove_file!
  end

  # This method will be removed in iOS 9
  def resource
    SugarCube.log('Warning: SugarCube\'s String#resource method has been deprecated in favor of String#resource_path')
    self.resource_path
  end

end
