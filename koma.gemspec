# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'koma/version'

Gem::Specification.new do |spec|
  spec.name          = 'koma'
  spec.version       = Koma::VERSION
  spec.authors       = ['k1LoW']
  spec.email         = ['k1lowxb@gmail.com']

  spec.summary       = 'Koma gather host inventory without agent.'
  spec.description   = 'Koma gather host inventory without agent.'
  spec.homepage      = 'https://github.com/k1LoW/koma'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thor'
  spec.add_runtime_dependency 'highline'
  spec.add_runtime_dependency 'specinfra', '~> 2.58'
  spec.add_runtime_dependency 'parallel'
  spec.add_runtime_dependency 'sconb', '~> 1.2'
  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'octorelease'
  spec.add_development_dependency 'pry'
end
