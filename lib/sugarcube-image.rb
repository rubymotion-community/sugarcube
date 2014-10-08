unless defined?(Motion::Project::Config)
  raise "The sugarcube gem must be required within a RubyMotion project Rakefile."
end


require 'sugarcube'

Motion::Project::App.pre_setup do |app|
  SugarCube.add_app_files(app, 'sugarcube-image')
end
