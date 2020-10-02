# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.3', '>= 6.0.3.3'

gem 'api-pagination', '~> 4.8'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'jbuilder', '~> 2.7'
gem 'kaminari', '~> 1.2'
gem 'puma', '~> 4.1'
gem 'sqlite3', '~> 1.4'

group :development, :test do
  gem 'rspec-rails', '~> 4.0.0'
  gem 'rubocop', require: false
end

group :test do
  gem 'factory_bot_rails', '~> 6.1'
  gem 'test-prof', '~> 0.12'
end

group :development do
  gem 'debase'
  gem 'listen', '~> 3.2'
  gem 'ruby-debug-ide'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
