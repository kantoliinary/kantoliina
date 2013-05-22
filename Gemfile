source 'https://rubygems.org'

gem 'rails', '3.2.13'

group :development do
  gem 'sqlite3', '1.3.5'
end

group :production do
  gem 'pg'
end

group :development, :test do
  gem "rspec-rails", ">= 2.0.1"
  gem "cucumber-rails", :require => false
  gem 'database_cleaner'
  gem 'cucumber-rails-training-wheels'
  gem 'capybara'
  gem 'rake'
  gem 'simplecov'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '3.2.5'
  gem 'coffee-rails', '3.2.2'

  gem 'uglifier', '1.2.3'
end

gem 'bcrypt-ruby'
gem 'jquery-rails', '2.0.2'
gem 'haml'
