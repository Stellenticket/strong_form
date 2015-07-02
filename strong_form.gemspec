$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'strong_form/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'strong_form'
  s.version     = StrongForm::VERSION
  s.authors     = ['Markus Doits']
  s.email       = ['markus.doits@stellenticket.de']
  s.homepage    = 'https://github.com/Stellenticket/strong_form'
  s.summary     = 'Strong Parameters for Forms'
  s.description = 'Allows to alter form fields based on permitted attributes.'
  s.license     = 'AGPL-3.0'

  s.files = Dir['{app,config,db,lib}/**/*', 'AGPL-LICENSE', 'Rakefile', 'README.md', 'CHANGELOG.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 4.0'

  s.add_development_dependency 'sqlite3', '> 1'
  s.add_development_dependency 'rspec-rails', '~> 3.0'
  s.add_development_dependency 'nested_form', '~> 0.3'
  s.add_development_dependency 'capybara', '~> 2.0'
  s.add_development_dependency 'haml-rails', '~> 0.9'
  s.add_development_dependency 'pry-rails', '~> 0.3'
end
