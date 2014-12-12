unless defined?(Motion::Project::Config)
  raise 'The sugarcube gem must be required within a RubyMotion project Rakefile.'
end


module SugarCube
  module_function

  class PlatformException < Exception
  end

  def ios_only!(package)
    unless ios?
      raise PlatformException.new("The '\033[0;1msugarcube-#{package}\033[0m' package is only available on iOS.")
    end
  end

  def osx_only!(package)
    unless osx?
      raise PlatformException.new("The '\033[0;1msugarcube-#{package}\033[0m' package is only available on OS X.")
    end
  end

  def cocoa_only!(package)
    unless cocoa?
      raise PlatformException.new("The '\033[0;1msugarcube-#{package}\033[0m' package is only available on OS X or iOS.")
    end
  end

  def android_only!(package)
    unless android?
      raise PlatformException.new("The '\033[0;1msugarcube-#{package}\033[0m' package is only available on Android.")
    end
  end

  def ios?
    App.template.to_s =~ /\bios\b/
  end

  def osx?
    App.template.to_s =~ /\bosx\b/
  end

  def android?
    App.template.to_s =~ /\bandroid\b/
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

  def add_app_files(app, package_name)
    # scans app.files until it finds app/ (the default)
    # if found, it inserts just before those files, otherwise it will insert to
    # the end of the list
    platforms = [SugarCube.platform]  # ios, osx, or android specific files
    if SugarCube.cocoa?
      platforms << 'cocoa'
    end
    platforms << 'all'

    platforms.reverse.each do |platform|
      Dir.glob(File.join(File.dirname(__FILE__), platform, package_name, '**/*.rb')).each do |file|
        app.files << file
      end
    end
  end

end

if ! App.respond_to?(:pre_setup)
  require 'sugarcube_pre_setup'
end

Motion::Project::App.pre_setup do |app|
  app.files << File.join(File.dirname(__FILE__), 'version.rb')

  SugarCube.add_app_files(app, 'sugarcube')
end

require File.join(File.dirname(__FILE__), 'sugarcube-to_s.rb')
