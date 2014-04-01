unless defined?(Motion::Project::Config)
  raise 'The sugarcube gem must be required within a RubyMotion project Rakefile.'
end


Motion::Project::App.setup do |app|
  # scans app.files until it finds app/ (the default)
  # if found, it inserts just before those files, otherwise it will insert to
  # the end of the list
  insert_point = app.files.find_index { |file| file =~ /^(?:\.\/)?app\// } || 0

  app.files.insert(insert_point, File.join(File.dirname(__FILE__), 'version.rb'))
  Dir.glob(File.join(File.dirname(__FILE__), App.template.to_s, 'sugarcube/**/*.rb')).reverse.each do |file|
    app.files.insert(insert_point, file)
  end
  Dir.glob(File.join(File.dirname(__FILE__), 'all/sugarcube/**/*.rb')).reverse.each do |file|
    app.files.insert(insert_point, file)
  end
end

require File.join(File.dirname(__FILE__), 'sugarcube-coregraphics.rb')
require File.join(File.dirname(__FILE__), 'sugarcube-to_s.rb')
