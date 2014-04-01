$:.unshift('/Library/RubyMotion/lib')

platform = ENV.fetch('platform', 'ios')
if platform == 'ios'
  require 'motion/project/template/ios'
elsif platform == 'osx'
  require 'motion/project/template/osx'
else
  raise "Unsupported platform #{ENV['platform']}"
end

require 'bundler'
Bundler.require
require 'sugarcube-all'

if platform == 'ios'
  require 'sugarcube-legacy'
end


Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'SugarCube'
  app.frameworks << 'CoreLocation'
  app.files.concat Dir.glob(File.join("app-#{app.template}", '**/*.rb'))

  if ENV['files']
    app.specs_dir = "spec/"
  else
    app.specs_dir = "spec/#{app.template}/"
    app.spec_files.concat Dir.glob('spec/cocoa/*.rb')
    app.spec_files.concat Dir.glob('spec/all/*.rb')
  end
end
