# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gman_client/version'

Gem::Specification.new do |spec|
  spec.name = 'gman_client'
  spec.version = GmanClient::VERSION
  spec.authors = %w(MichaelAChrisco josephbridgwaterrowe)
  spec.email = ['joe@westernmilling.com']
  spec.summary = 'Grossman API Client for Ruby'
  spec.description =
    'Grossman API Client for accessing gman-services written in Ruby.'
  spec.homepage = 'https://github.com/westernmilling/gman_client'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.add_runtime_dependency 'vcr', '3.0.1'
  spec.add_runtime_dependency 'webmock', '1.22.6'
  spec.add_dependency 'blanket_wrapper', '3.0.2'
  spec.add_dependency 'hashie', '3.4.3'
  spec.add_dependency 'retries', '0.0.5'
  spec.add_dependency 'rest-client', '1.8.0'
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '3.4.0'
  spec.add_development_dependency 'rspec-its', '1.2.0'
end
