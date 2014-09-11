unless defined?(Motion::Project::Config)
  raise 'The sugarcube gem must be required within a RubyMotion project Rakefile.'
end


module SugarCube
  module_function

  def ios_only!(package)
    unless ios?
      raise "The '\033[0;1msugarcube-#{package}\033[0m' package is only available on iOS."
    end
  end

  def osx_only!(package)
    unless osx?
      raise "The '\033[0;1msugarcube-#{package}\033[0m' package is only available on OS X."
    end
  end

  def cocoa_only!(package)
    unless cocoa?
      raise "The '\033[0;1msugarcube-#{package}\033[0m' package is only available on OS X or iOS."
    end
  end

  def ios?
    App.template.to_s =~ /ios/
  end

  def osx?
    App.template.to_s =~ /osx/
  end

  def android?
    App.template.to_s =~ /android/
  end

  def cocoa?
    ios? || osx?
  end

  def platform
    if ios?
      'ios'
    elsif osx?
      'osx'
    elsif android?
      'android'
    else
      App.template.to_s
    end
  end

end

Motion::Project::App.setup do |app|
  # scans app.files until it finds app/ (the default)
  # if found, it inserts just before those files, otherwise it will insert to
  # the end of the list
  insert_point = app.files.find_index { |file| file =~ /^(?:\.\/)?app\// } || 0

  app.files.insert(insert_point, File.join(File.dirname(__FILE__), 'version.rb'))
  Dir.glob(File.join(File.dirname(__FILE__), SugarCube.platform, 'sugarcube/**/*.rb')).reverse.each do |file|
    app.files.insert(insert_point, file)
  end
  Dir.glob(File.join(File.dirname(__FILE__), 'cocoa/sugarcube/**/*.rb')).reverse.each do |file|
    app.files.insert(insert_point, file)
  end
  Dir.glob(File.join(File.dirname(__FILE__), 'all/sugarcube/**/*.rb')).reverse.each do |file|
    app.files.insert(insert_point, file)
  end
end

require File.join(File.dirname(__FILE__), 'sugarcube-coregraphics.rb')
require File.join(File.dirname(__FILE__), 'sugarcube-to_s.rb')
