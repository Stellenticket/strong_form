source 'https://rubygems.org'

# Declare your gem's dependencies in strong_form.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

if ENV['RAILS_VERSION'] == '5'
  gem 'rails', '~> 5.x'
  %w(rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support).each do |lib|
    gem lib, git: "git://github.com/rspec/#{lib}.git", branch: 'master'
  end
end

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]
