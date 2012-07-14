unless defined?(Motion::Project::Config)
  raise "sweettea must be required within a RubyMotion project Rakefile."
end


Motion::Project::App.setup do |app|
  # scans app.files until it finds /sugarcube/
  insert_point = 0
  app.files.each_index do |index|
    file = app.files[index]
    if file =~ /sugarcube/
      insert_point = index + 1
    elsif insert_point
      # found one, so stop looking
      break
    end
  end
  if not insert_point
    raise "sweettea must be required after sugarcube."
  end

  app.files.insert_point(insert_point, File.join(File.dirname(__FILE__), 'sweettea/handlers.rb'))
end
