require 'sugarcube'

exclude = [
  'sugarcube-all.rb',
  'sugarcube-common.rb',
  'sugarcube-classic.rb',
  'sugarcube-legacy.rb',
  'sugarcube-uicolor.rb',
  'sugarcube-uiimage.rb',
]

if App.template == :ios
  exclude += [
    'sugarcube-appkit.rb',
  ]
elsif App.template == :osx
  exclude += [
    'sugarcube-568.rb',
    'sugarcube-gestures.rb',
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
