# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "rails", "5.2.1"
gem "puma", "~> 3.11"
gem "pg", "0.21.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails"
gem "jquery-rails"
gem "turbolinks"
gem "jbuilder", "~> 2.0"
gem "sdoc", "~> 0.4.0", group: :doc
gem "bcrypt", "~> 3.1.7"
gem "will_paginate", "3.1.0"
gem "bootstrap-will_paginate", "0.0.10"
gem "bootstrap-sass", "~> 3.3.6"
gem "sass-rails", ">= 3.2"
gem "font-awesome-sass"
gem "carrierwave", "0.11.2"
gem "mini_magick", "4.5.1"
gem "fog", "1.38.0"
# gem "geocoder", "~> 1.5"
gem "gmaps4rails"
gem "i18n"
gem "rubocop-rails_config"
gem "stripe"
gem "rqrcode"
gem "aws-sdk-s3", require: false
gem "chunky_png", "~> 1.3", ">= 1.3.10"
gem "mail", "~> 2.7"

group :production do
  gem "rails_12factor"
end

group :development, :test do
  gem "byebug"
  # Use sqlite3 as the database for Active Record
  gem "sqlite3"
  gem "pry"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "~> 2.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "rspec-rails", "~> 3.8"
  gem "capybara", ">= 2.15"
  gem "factory_bot_rails", "~> 4.0"
  gem "database_cleaner"
  gem "rails-controller-testing", "1.0.2"
  gem "minitest-reporters",       "1.1.14"
  gem "guard",                    "2.13.0"
  gem "guard-minitest",           "2.4.4"
  gem "simplecov", "~> 0.16.1"
  gem "shoulda-matchers", "~> 3.1"
  # gem "selenium-webdriver"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
