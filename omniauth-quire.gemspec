# frozen_string_literal: true

require_relative 'lib/omniauth/quire/version'

Gem::Specification.new do |spec|
  spec.name = 'omniauth-quire'
  spec.version = Omniauth::Quire::VERSION
  spec.authors = ['Kalpana']
  spec.email = ['kalpana.sharma0795@gmail.com']

  spec.summary = 'Omniauth Strategy for Quire'
  spec.homepage = 'https://github.com/kalpana0795/omniauth-quire'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.5.0'

  spec.metadata['allowed_push_host'] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/kalpana0795/omniauth-quire'
  spec.metadata['changelog_uri'] = 'https://github.com/kalpana0795/omniauth-quire/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|spec)/|\.(?:github))})
    end
  end
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'omniauth-oauth2', '>= 1.2', '< 3'
  spec.add_development_dependency 'rspec', '~> 3.12'
end
