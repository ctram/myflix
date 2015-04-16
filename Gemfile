source 'https://rubygems.org'
# ruby '2.1.1'
ruby '2.1.3'

gem 'rack-timeout'
gem 'unicorn'
gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'pg'
gem 'bcrypt'
gem 'fabrication'
gem 'faker'
gem 'sidekiq'


group :development do
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'letter_opener'
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails', '2.99'
end

group :test do
  gem 'capybara'
  gem 'capybara-email'
  gem 'shoulda'
  gem 'database_cleaner', '1.2.0'
end

group :production do
  gem 'rails_12factor'
end
