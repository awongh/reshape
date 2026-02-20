# frozen_string_literal: true

require 'English'
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reshape/version'

Gem::Specification.new do |gem|
  gem.name          = 'reshape'
  gem.version       = Reshape::VERSION
  gem.authors       = ['John Barton']
  gem.email         = ['jb@phy5ics.com']
  gem.description   = 'A client for the Shapeways 3D printing API.'
  gem.summary       = 'A client for the Shapeways 3D printing API.'
  gem.homepage      = 'https://github.com/phy5ics/reshape'

  gem.required_ruby_version = ['>= 3.2.10', '< 5']

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_dependency 'faraday', '~> 2.0'
  gem.add_dependency 'faraday-mashify', '~> 1.0'
  gem.add_dependency 'hashie', '~> 5.0'

  gem.metadata['rubygems_mfa_required'] = 'true'
end
