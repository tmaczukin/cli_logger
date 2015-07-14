# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cli_logger/version'

Gem::Specification.new do |spec|
  spec.name          = 'cli_logger'
  spec.version       = CliLogger::VERSION
  spec.authors       = ['Tomasz Maczukin']
  spec.email         = ['tomasz@maczukin.pl']

  spec.summary       = 'TODO: Write a short summary, because Rubygems requires one.'
  spec.description   = 'TODO: Write a longer description or delete this line.'
  spec.homepage      = 'https://github.com/tmaczukin/cli_logger'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(/^spec/) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler',   '~> 1.8'
  spec.add_development_dependency 'rake',      '~> 10.0'
  spec.add_development_dependency 'rubocop',   '~> 0.31.0'
  spec.add_development_dependency 'rspec',     '~> 3.2.0'
  spec.add_development_dependency 'pry',       '~> 0.10.1'
  spec.add_development_dependency 'simplecov', '~> 0.10.0'

  spec.add_dependency 'colorize', '~> 0.7.5'
end
