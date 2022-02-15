# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.1"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "6.1.4.1"
# Use postgresql as the database for Active Record
gem "pg", "1.3.2"
# Use Puma as the app server
gem "puma", "5.5.2"
# Use SCSS for stylesheets
gem "sass-rails", "6.0.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", "4.2.0"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker", "5.4.3"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "5.0.0"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "5.2.1"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "2.11.2"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", "1.9.1", require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", "11.1.3", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails", "2.7.6"
  gem "rubocop", "1.22.1"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "listen", "3.7.0"
  gem "web-console", "4.1.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring", "2.1.1"
  gem "spring-watcher-listen", "2.0.1"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", "3.35.3"
  gem "selenium-webdriver", "3.142.7"
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem "chromedriver-helper", "2.1.1"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", "1.2.5", platforms: %i[mingw mswin x64_mingw jruby]

gem "active_link_to", "1.0.5"
gem "pry-rails", "0.3.9"
gem "rspotify", git: "https://github.com/jabawack81/rspotify.git"
gem "will_paginate", "3.3.1"
