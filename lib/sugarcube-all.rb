require 'sugarcube'

exclude = [
  'sugarcube-all.rb',
  'sugarcube-common.rb',
  'sugarcube-classic.rb',
  'sugarcube-legacy.rb',
  'sugarcube-appkit.rb',  # renamed in 3.0.0 to 'sugarcube-ui'
  'sugarcube-uikit.rb',   # renamed in 3.0.0 to 'sugarcube-ui'
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
elsif SugarCube.android?
  exclude += [
  ]
end

dirname = File.dirname(__FILE__)
Dir.glob(File.join(dirname, '*.rb')).each do |file|
  filename = File.basename(file)
  unless exclude.include? filename
    begin
      require file
    rescue SugarCube::PlatformException => e
    end
  end
end
