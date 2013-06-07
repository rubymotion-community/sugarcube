ignore = [
  'sugarcube-all.rb',
  'sugarcube-legacy.rb',
  'sugarcube-unholy.rb',
  'sugarcube-anonymous.rb',
  'sugarcube-awesome.rb',
  'sugarcube-osx.rb',
]

dirname = File.dirname(__FILE__)
Dir.glob(File.join(dirname, '*.rb')).each do |file|
  file = File.basename(file)
  unless ignore.include? file
    file = File.join(dirname, file)
    require file
  end
end
