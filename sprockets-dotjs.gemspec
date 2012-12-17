# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sprockets-dotjs/version'

Gem::Specification.new do |gem|
  gem.name          = "sprockets-dotjs"
  gem.version       = Sprockets::Dotjs::VERSION
  gem.authors       = ["Le Duc Duy"]
  gem.email         = ["me@duy.kr"]
  gem.description   = "Compile dot.js template into javascript"
  gem.summary       = "Compile dot.js template into javascript"
  gem.homepage      = "https://github.com/duyleekun/sprockets-dotjs"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "sprockets"
  gem.add_development_dependency "libv8"
  gem.add_development_dependency "therubyracer"

end
