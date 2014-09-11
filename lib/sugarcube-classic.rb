exclude = [
  'sugarcube-all.rb',
  'sugarcube-common.rb',
  'sugarcube-classic.rb',
  'sugarcube-legacy.rb',
  'sugarcube-uicolor.rb',
  'sugarcube-uiimage.rb',
  'sugarcube-spritekit.rb',

  'sugarcube-568.rb',
  'sugarcube-anonymous.rb',
  'sugarcube-attributedstring.rb',
  'sugarcube-awesome.rb',
  'sugarcube-gestures.rb',
  'sugarcube-pipes.rb',
  'sugarcube-repl.rb',
  'sugarcube-unholy.rb',
]

if SugarCube.ios?
  exclude += [
    'sugarcube-appkit.rb',
  ]
elsif SugarCube.osx?
  exclude += [
    'sugarcube-modal.rb',
    'sugarcube-uikit.rb',
  ]
end

dirname = File.dirname(__FILE__)
Dir.glob(File.join(dirname, '*.rb')).each do |file|
  filename = File.basename(file)
  unless exclude.include? filename
    require file
  end
end
