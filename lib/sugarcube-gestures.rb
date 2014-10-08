unless defined?(Motion::Project::Config)
  raise "The sugarcube gem must be required within a RubyMotion project Rakefile."
end


require 'sugarcube'
SugarCube.ios_only!('gestures')

Motion::Project::App.pre_setup do |app|
  SugarCube.add_app_files(app, 'sugarcube-gestures')
end
