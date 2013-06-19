ignore = [
  'sugarcube-all.rb',
  'sugarcube-common.rb',
  'sugarcube-classic.rb',
  'sugarcube-osx.rb',
  'sugarcube-legacy.rb',
  'sugarcube-uicolor.rb',
]

dirname = File.dirname(__FILE__)
Dir.glob(File.join(dirname, '*.rb')).each do |file|
  file = File.basename(file)
  unless ignore.include? file
    file = File.join(dirname, file)
    require file
  end
end
