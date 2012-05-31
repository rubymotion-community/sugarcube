# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sugarcube/version.rb', __FILE__)

Gem::Specification.new do |gem|

  gem.authors = ['Colin Thomas-Arnold', 'Chris Clarke']
  gem.email   = 'colin@fusionbox.com'
  gem.summary     = %{Extensions for Ruby to make Rubymotion development more enjoyable, and hopefully more rubyesque!}
  gem.description = <<-DESC
      CocoaTouch/iOS is a *verbose* framework.  These extensions hope to make
      development in rubymotion more enjoyable by tacking "UI" methods onto the
      base classes (String, Fixnum, Float).  With sugarcube, you can create a
      color from an integer or symbol, or create a UIFont or UIImage from a
      string.

      Some UI classes are opened up as well, like adding the '<<' operator to a
      UIView instance, instead of view.addSubview(subview), you can use the more
      idiomatic: view << subview.
      DESC

  gem.homepage    = 'https://github.com/fusionbox/sugarcube'

  gem.files       = [ ] # Put all your files in here (TODO)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.name          = 'sugarcube'
  gem.require_paths = ['lib']
  gem.version       = SugarCube::VERSION

  # Put dependencies here
  # e.g. gem.add_dependency "some_gem", "~> optional_version_number"

end
