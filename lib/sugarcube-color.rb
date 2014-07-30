unless defined?(Motion::Project::Config)
  raise "The sugarcube gem must be required within a RubyMotion project Rakefile."
end


require 'sugarcube'

Motion::Project::App.setup do |app|
  # scans app.files until it finds app/ (the default)
  # if found, it inserts just before those files, otherwise it will insert to
  # the end of the list
  insert_point = app.files.find_index { |file| file =~ /^(?:\.\/)?app\// } || 0

  Dir.glob(File.join(File.dirname(__FILE__), App.template.to_s, 'sugarcube-color/**/*.rb')).reverse.each do |file|
    app.files.insert(insert_point, file)
  end

  look_in = File.join(File.dirname(__FILE__), 'sugarcube/look_in.rb')
  app.files.insert(insert_point, look_in)
end
