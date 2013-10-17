unless defined?(Motion::Project::Config)
  raise "The sugarcube gem must be required within a RubyMotion project Rakefile."
end


Motion::Project::App.setup do |app|
  # scans app.files until it finds app/ (the default)
  # if found, it inserts just before those files, otherwise it will insert to
  # the end of the list
  insert_point = app.files.find_index { |file| file =~ /^(?:\.\/)?app\// } || 0

  Dir.glob(File.join(File.dirname(__FILE__), 'sugarcube-events/**/*.rb')).reverse.each do |file|
    app.files.insert(insert_point, file)
  end

  cleanup = File.join(File.dirname(__FILE__), 'sugarcube/sugarcube_cleanup.rb')
  uicontrol = File.join(File.dirname(__FILE__), 'sugarcube-events/uicontrol.rb')
  uitextview = File.join(File.dirname(__FILE__), 'sugarcube-events/uitextview.rb')
  app.files_dependencies uicontrol => [cleanup], uitextview => [cleanup]
end
