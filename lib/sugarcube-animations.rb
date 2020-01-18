unless defined?(Motion::Project::Config)
  raise "The sugarcube gem must be required within a RubyMotion project Rakefile."
end


require 'sugarcube'
if SugarCube.cocoa?
  require 'sugarcube-coregraphics'
end

Motion::Project::App.pre_setup do |app|
  SugarCube.add_app_files(app, 'sugarcube-animations')
end

Motion::Project::App.post_setup do |app|
  app.frameworks += %w{QuartzCore}
end
