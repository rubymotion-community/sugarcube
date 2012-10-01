# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sugarcube/version.rb', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'sugarcube'
  gem.version       = SugarCube::Version

  gem.authors = ['Colin Thomas-Arnold', 'Fusionbox']
  gem.email   = ['colinta@gmail.com']
  gem.summary     = %{Extensions for Ruby to make Rubymotion development more enjoyable, and hopefully more rubyesque!}
  gem.description = <<-DESC
== Description

CocoaTouch/iOS is a *verbose* framework.  These extensions hope to make
development in rubymotion more enjoyable by tacking "UI" methods onto the
base classes (String, Fixnum, Float).  With sugarcube, you can create a
color from an integer or symbol, or create a UIFont or UIImage from a
string.

Some UI classes are opened up as well, like adding the <tt><<</tt> operator to a
<tt>UIView</tt> instance, instead of <tt>view.addSubview(subview)</tt>, you can
use the more idiomatic: <tt>view << subview</tt>.
DESC

  gem.homepage    = 'https://github.com/rubymotion/sugarcube'

  gem.files        = `git ls-files`.split($\)
  gem.executables  = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files   = gem.files.grep(%r{^spec/})

  gem.require_paths = ['lib']
end
