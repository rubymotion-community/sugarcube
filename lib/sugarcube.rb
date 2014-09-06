require File.join(File.dirname(__FILE__), 'sugarcube-core.rb')


module SugarCube
  module_function

  def ios_only!(package)
    unless App.template.to_s =~ /ios/
      raise "The '\033[0;1msugarcube-#{package}\033[0m' package is only available on iOS."
    end
  end

  def osx_only!(package)
    unless App.template.to_s == /osx/
      raise "The '\033[0;1msugarcube-#{package}\033[0m' package is only available on OS X."
    end
  end

end
