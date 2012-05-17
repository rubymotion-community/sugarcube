# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sugarcube/version.rb', __FILE__)

Gem::Specification.new do |gem|

  gem.authors = ['Colin Thomas-Arnold', 'Chris Clarke']
  gem.email   = # TODO
  gem.description = %{A little helper library for RubyMotion.}
  gem.summary     = %{A helper library for RubyMotion.}

  gem.homepage    = 'https://github.com/colinta/sugarcube'

  gem.files       = [ ] # Put all your files in here (TODO)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.name          = 'sugarcube'
  gem.require_paths = ['lib']
  gem.version       = SugarCube::VERSION
  
  # Put dependencies here
  # e.g. gem.add_dependency "some_gem", "~> optional_version_number"

end
