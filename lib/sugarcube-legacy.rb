unless defined?(Motion::Project::Config)
  raise "The sugarcube gem must be required within a RubyMotion project Rakefile."
end


require 'sugarcube'

Motion::Project::App.setup do |app|
  # scans app.files until it finds app/ (the default)
  # if found, it inserts just before those files, otherwise it will insert to
  # the end of the list
  insert_point = app.files.find_index { |file| file =~ /^(?:\.\/)?app\// } || 0

  if SugarCube.ios?
    Dir.glob(File.join(File.dirname(__FILE__), 'ios/sugarcube/**/*.rb')).reverse.each do |file|
      app.files.insert(insert_point, file)
    end
  end

  Dir.glob(File.join(File.dirname(__FILE__), 'cocoa/sugarcube-legacy/**/*.rb')).reverse.each do |file|
    app.files.insert(insert_point, file)
  end
  Dir.glob(File.join(File.dirname(__FILE__), 'all/sugarcube-legacy/**/*.rb')).reverse.each do |file|
    app.files.insert(insert_point, file)
  end
end
