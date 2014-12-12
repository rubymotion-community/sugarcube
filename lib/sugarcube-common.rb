require 'sugarcube'

exclude = [
  'sugarcube-all.rb',
  'sugarcube-common.rb',
  'sugarcube-classic.rb',
  'sugarcube-legacy.rb',

  'sugarcube-anonymous.rb',
  'sugarcube-awesome.rb',
  'sugarcube-pipes.rb',
  'sugarcube-unholy.rb',
  'sugarcube-appkit.rb',
  'sugarcube-uikit.rb',
]

if SugarCube.ios?
  exclude += [
  ]
elsif SugarCube.osx?
  exclude += [
    'sugarcube-568.rb',
    'sugarcube-gestures.rb',
    'sugarcube-modal.rb',
  ]
end

dirname = File.dirname(__FILE__)
Dir.glob(File.join(dirname, '*.rb')).each do |file|
  filename = File.basename(file)
  unless exclude.include? filename
    require file
  end
end
