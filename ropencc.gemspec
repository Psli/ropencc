# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ropencc/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Psi"]
  gem.email         = ["psi.xie@gmail.com"]
  gem.description   = %q{ a project for conversion between Traditional and Simplified Chinese, wrapper in ruby. }
  gem.summary       = %q{ a project for conversion between Traditional and Simplified Chinese. }
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "ropencc"
  gem.require_paths = ["lib"]
  gem.version       = Ropencc::VERSION
end
