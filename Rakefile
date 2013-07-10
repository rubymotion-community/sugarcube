$:.unshift('/Library/RubyMotion/lib')
require 'motion/project'
require './lib/sugarcube'
require './lib/sugarcube-gestures'
require './lib/sugarcube-568'
require './lib/sugarcube-attributedstring'
require './lib/sugarcube-unholy'
require './lib/sugarcube-anonymous'
require 'rake/hooks'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'SugarCube'

  app.frameworks << 'CoreLocation'
end

before :spec do
  cwd = File.dirname(__FILE__)
  path = File.join(cwd, 'README.md')

  lines = ['describe "README.md" do']
  open(path).read.scan(/```ruby\n((?:.*?\n)+?)```/).flatten.each_with_index do |code, i|
    lines << "  it 'code snippet ##{i+1}' do"
    lines << '    lambda {'
    lines << code.split("\n").map{|x| " " * 6 + x}.join("\n")
    lines << '    }.should.not.raise(Exception)'
    lines << '  end'
    lines << ''
  end
  lines << 'end'

  open(File.join(cwd, "spec", "doc_spec.rb"), "w").write(lines.join("\n"))
end
