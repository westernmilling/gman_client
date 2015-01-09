# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gman_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'gman_client'
  spec.version       = GmanClient::VERSION
  spec.authors       = ['MichaelAChrisco']
  spec.email         = ['michaelachrisco@gmail.com']
  spec.summary       = 'GMAN gem client'
  spec.description   = 'GMAN gem client for Grossman API'
  spec.homepage      = 'https://github.com/michaelachrisco/gman_client'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.add_runtime_dependency 'vcr'
  spec.add_runtime_dependency 'webmock'
  spec.add_development_dependency 'blanket_wrapper'
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rest-client'

end
