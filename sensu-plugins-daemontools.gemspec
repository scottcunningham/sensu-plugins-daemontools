require 'date'
require 'sensu-plugins-daemontools'

Gem::Specification.new do |s|
  s.authors                = ['Ensighten', 'Scott Cunningham']
  s.date                   = Date.today.to_s
  s.description            = 'This plugin provides checks for daemontools services'
  s.email                  = '<infra@ensighten.com>'
  s.executables            = Dir.glob('bin/**/*.rb').map { |file| File.basename(file) }
  s.files                  = Dir.glob('{bin,lib}/**/*') + %w(LICENSE README.md CHANGELOG.md)
  s.test_files             = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths          = ["lib"]
  s.platform               = Gem::Platform::RUBY
  s.required_ruby_version  = '>= 2.0.0'

  s.add_runtime_dependency 'sensu-plugin'

  s.add_development_dependency 'codeclimate-test-reporter'
  s.add_development_dependency 'rubocop', '~> 0.17.0'
  s.add_development_dependency 'rspec', '~> 3.1'
  s.add_development_dependency 'bundler', '~> 1.7'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'github-markup'
  s.add_development_dependency 'redcarpet'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'pry'
  s.metadata               = { 'maintainer'         => 'ensighten',
                               'development_status' => 'active',
                               'production_status'  => 'unstable - testing recommended',
                               'release_draft'      => 'false',
                               'release_prerelease' => 'false' }
  s.name                   = 'sensu-plugins-daemontools'
  s.summary                = 'Sensu plugins for checking daemontools services'
  s.version                = SensuPluginsDaemontools::Version::VER_STRING
end
