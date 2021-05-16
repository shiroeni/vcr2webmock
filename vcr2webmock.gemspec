require_relative 'lib/vcr2webmock/version'

Gem::Specification.new do |spec|
  spec.name          = 'vcr2webmock'
  spec.version       = Vcr2webmock::VERSION
  spec.authors       = ['Eugene Palchikov']
  spec.email         = ['me@aryon.dev']

  spec.summary       = 'some summary'
  spec.homepage      = 'http://example.com'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  spec.metadata['homepage_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f|
      f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]
end
