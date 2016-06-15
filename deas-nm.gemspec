# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "deas-nm/version"

Gem::Specification.new do |gem|
  gem.name        = "deas-nm"
  gem.version     = Deas::Nm::VERSION
  gem.authors     = ["Kelly Redding", "Collin Redding"]
  gem.email       = ["kelly@kellyredding.com", "collin.redding@me.com"]
  gem.summary     = %q{Deas template engine for Nm templates}
  gem.description = %q{Deas template engine for Nm templates}
  gem.homepage    = "http://github.com/redding/deas-nm"
  gem.license     = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency("assert", ["~> 2.16.1"])

  gem.add_dependency("deas", ["~> 0.41.0"])
  gem.add_dependency("nm",   ["~> 0.5.3"])

end
