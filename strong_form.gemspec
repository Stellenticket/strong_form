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

  s.files = Dir['{app,config,db,lib}/**/*', 'AGPL-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 4.2'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails', '~> 3.3'
  s.add_development_dependency 'nested_form'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'haml-rails'
  s.add_development_dependency 'pry-rails'
end
