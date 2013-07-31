ignore = [
  'sugarcube-all.rb',
  'sugarcube-common.rb',
  'sugarcube-classic.rb',
  'sugarcube-osx.rb',
  'sugarcube-legacy.rb',
  'sugarcube-uicolor.rb',
  'sugarcube-uiimage.rb',

  'sugarcube-568.rb',
  'sugarcube-anonymous.rb',
  'sugarcube-attributedstring.rb',
  'sugarcube-awesome.rb',
  'sugarcube-gestures.rb',
  'sugarcube-pipes.rb',
  'sugarcube-repl.rb',
  'sugarcube-unholy.rb',
]

dirname = File.dirname(__FILE__)
Dir.glob(File.join(dirname, '*.rb')).each do |file|
  file = File.basename(file)
  unless ignore.include? file
    file = File.join(dirname, file)
    require file
  end
end
