unless defined?(Motion::Project::Config)
  raise "The sugarcube gem must be required within a RubyMotion project Rakefile."
end


require 'sugarcube'
SugarCube.cocoa_only!('corelocation')

Motion::Project::App.pre_setup do |app|
  SugarCube.add_app_files(app, 'sugarcube-corelocation')
end

Motion::Project::App.post_setup do |app|
  app.frameworks += %w{CoreLocation}
end
