# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gorilla/version'

Gem::Specification.new do |spec|
  spec.name          = 'gorilla-io'
  spec.version       = Gorilla::VERSION
  spec.authors       = ['Gorilla.io']
  spec.email         = ['braden@gorilla.io']
  spec.summary       = %q{Ruby wrapper for the Gorilla.io API}
  spec.description   = %q{Ruby wrapper for the Gorilla.io API}
  spec.homepage      = 'https://github.com/thinkmechanic/gorilla-ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_dependency 'faraday', '~> 0.9'
  spec.add_dependency 'faraday_middleware', '~> 0.9'
  spec.add_dependency 'configurations', '~> 1.4'
  spec.add_dependency 'jwt', '~> 1.2'
end
