unless defined?(Motion::Project::Config)
  raise "sweettea must be required within a RubyMotion project Rakefile."
end


Motion::Project::App.setup do |app|
  # scans app.files until it finds /sugarcube/
  sugarcube_insert_point = 0
  app.files.each_index do |index|
    file = app.files[index]
    if file =~ /sugarcube/
      sugarcube_insert_point = index + 1
    elsif sugarcube_insert_point
      # found one, so stop looking
      break
    end
  end

  if not sugarcube_insert_point
    raise "sweettea must be required after sugarcube."
  end

  # scans app.files until it finds /teacup/
  teacup_insert_point = 0
  app.files.each_index do |index|
    file = app.files[index]
    if file =~ /teacup/
      teacup_insert_point = index + 1
    elsif teacup_insert_point
      # found one, so stop looking
      break
    end
  end

  if not teacup_insert_point
    raise "sweettea must be required after teacup."
  end

  insert_point = sugarcube_insert_point > teacup_insert_point ? sugarcube_insert_point : teacup_insert_point

  app.files.insert(insert_point, File.join(File.dirname(__FILE__), 'sweettea/handlers.rb'))
end
