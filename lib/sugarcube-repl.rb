unless defined?(Motion::Project::Config)
  raise "The sugarcube gem must be required within a RubyMotion project Rakefile."
end


require 'sugarcube'

Motion::Project::App.pre_setup do |app|
  app.development do
    SugarCube.add_app_files(app, 'sugarcube-repl')
  end
end
