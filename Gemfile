# frozen_string_literal: true

source "https://rubygems.org"


gem "rails", "5.0.2"
gem "pg", "0.21.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.1.0"
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
gem "geocoder"
gem "gmaps4rails"
gem "i18n"
gem "rubocop-rails_config"

# Suite of testing facilities supporting TDD, BDD, mocking, and benchmarking
gem "minitest", "~> 5.10", "!= 5.10.2"

group :production do
  gem "rails_12factor"
end

group :development, :test do
  gem "byebug"
  gem "pry"
  # Use sqlite3 as the database for Active Record
  gem "sqlite3"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "~> 2.0"
end

group :test do
  gem "rspec-rails", "~> 3.8"
  gem "capybara", "~> 3.7", ">= 3.7.2"
  gem "factory_bot_rails", "~> 4.0"

  gem "rails-controller-testing", "1.0.2"
  gem "minitest-reporters",       "1.1.14"
  gem "guard",                    "2.13.0"
  gem "guard-minitest",           "2.4.4"
  gem "simplecov",                "0.15.1", require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
