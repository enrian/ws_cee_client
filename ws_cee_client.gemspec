# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'ws_cee_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'ws_cee_client'
  spec.version       = WsCee::VERSION
  spec.authors       = ['Jaromír Červenka']
  spec.email         = ['jaromir@virt.io']

  spec.summary       = %q{Client for communication with Czech Database of Distraints. Connected to Bisnode WS CEE SOAP API.}
  spec.homepage      = 'https://github.com/enrian/ws_cee_client'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'savon', '~> 2.0'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'
end
