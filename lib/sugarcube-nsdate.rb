unless defined?(Motion::Project::Config)
  raise "The sugarcube gem must be required within a RubyMotion project Rakefile."
end


unless defined?(SugarCube)
  require 'sugarcube'
end

Motion::Project::App.setup do |app|
  # scans app.files until it finds app/ (the default)
  # if found, it inserts just before those files, otherwise it will insert to
  # the end of the list
  insert_point = app.files.find_index { |file| file =~ /^(?:\.\/)?app\// } || 0

  Dir.glob(File.join(File.dirname(__FILE__), 'cocoa/sugarcube-nsdate/**/*.rb')).reverse.each do |file|
    app.files.insert(insert_point, file)
  end

  time_rb = File.join(File.dirname(__FILE__), 'all/sugarcube-numbers/time.rb')
  unless app.files.include?(time_rb)
    app.files.insert(insert_point, time_rb)
  end
end
