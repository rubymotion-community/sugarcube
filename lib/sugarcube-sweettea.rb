unless defined?(Motion::Project::Config)
  raise "sweettea must be required within a RubyMotion project Rakefile."
end


Motion::Project::App.setup do |app|
  insert = nil
  app.files.each_index do |index|
    file = app.files[index]
    if file =~ /sugarcube/
      insert = index + 1
    elsif insert
      # found one, so stop looking
      break
    end
  end
  if not insert
    raise "sweettea must be required after sugarcube."
  end

  app.files.insert(insert, File.join(File.dirname(__FILE__), 'sweettea/handlers.rb'))
end
