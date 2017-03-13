source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.3.3'

gem 'rails', '~> 5.0.2'

gem 'configatron'
gem 'keen'
gem 'newrelic_rpm'
gem 'puma', '~> 3.0'
gem 'pg'
gem 'rollbar'
gem 'scout_apm'
gem 'silencer', '~> 1.0'
gem 'slack-ruby-client'
gem 'thor-rails'

group :development, :test do
  gem 'awesome_print'
  gem 'byebug', platform: :mri
  gem 'dotenv-rails'
  gem 'pry-rails'
  gem 'sqlite3'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'rubocop'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
