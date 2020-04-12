lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'luxafor/toggl/version'

Gem::Specification.new do |spec|
  spec.name          = 'luxafor-toggl'
  spec.version       = Luxafor::Toggl::VERSION
  spec.authors       = ['Gabriel Fortuna']
  spec.email         = ['gabriel@zero-one.io']

  spec.summary       = 'Integrate your Luxafor flag with your toggl account'
  spec.description   = 'A simple utility to integrate and sync your Toggl activity with your Luxafor flag'
  spec.homepage      = 'https://www.zero-one.io'
  spec.licenses      = 'MIT'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/gee-forr/luxafor-toggl'
  # spec.metadata['changelog_uri']   = 'TODO: Put your gem's CHANGELOG.md URL here.'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'awesome_print', '~> 1'
  spec.add_development_dependency 'bundler',       '~> 2.0'
  spec.add_development_dependency 'pry',           '0.13.1'
  spec.add_development_dependency 'rake',          '>= 12.3.3'
  spec.add_development_dependency 'rspec',         '~> 3.0'

  spec.add_dependency 'luxafor',         '~> 0.1.0'
  spec.add_dependency 'oj',              '~> 3.10', '>= 3.10.6'
  spec.add_dependency 'togglv8',         '~> 1.2',  '>= 1.2.1'
  spec.add_dependency 'value_semantics', '~> 3.2'
end
