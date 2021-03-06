# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_easy_caching/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_easy_caching"
  spec.version       = RailsEasyCaching::VERSION
  spec.authors       = ["Tien Nguyen"]
  spec.email         = ["nqtien310@gmail.com"]
  spec.summary       = %q{Simple wrapper for Rails cache}
  spec.description   = %q{using EasyCaching is as easy as defining which methods/scopes/associations that you wanna cache.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
