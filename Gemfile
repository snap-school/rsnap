source "https://rubygems.org"
gem "bower-rails", "~> 0.7"

ruby "2.1.1"
gem "rails", "~> 4.1.3"
gem "pg"

gem "jbuilder", "~> 2.0"

gem "bcrypt", "~> 3.1"
gem "authority", "~> 3"
gem "devise", "~> 3.2"
gem "devise-i18n"
gem "omniauth-openid"

gem "ranked-model"

gem "paperclip", "~> 4.1"
gem "aws-sdk", "~> 1.5"
gem "rmagick", "~> 2.13"

gem "uglifier", ">= 1.3"
gem "sass-rails", "~> 4.0"
gem "haml", "~> 4.0"
gem "haml-rails", "~> 0.5"
gem "coffee-rails", "~> 4.0"
gem "turbolinks", "~> 2.2"
gem "jquery-rails"
gem "jquery-ui-rails"
gem "jquery-turbolinks"
gem "therubyracer", platforms: :ruby, require: "v8"
gem "bootstrap-sass", "~> 3.1"
gem "bootstrap_forms", github: "gagalago/bootstrap_forms", branch: "bootstrap3"

gem "sitemap_generator"

gem "dotenv-rails"
gem "travis"

group :development do
  gem "travis-lint"
  gem "metric_fu"
  gem "rails-erd"
  gem "railroady"
end

group :development, :test do
  gem "debugger"
  gem "coveralls", require: false
  gem "codeclimate-test-reporter", require: false
end

group :test do
  gem "rspec-rails"

  gem "factory_girl_rails", "~> 4.3"
  gem "faker"

  gem "cucumber-rails", "~> 1.4", require: false
  gem "launchy"
  gem "database_cleaner", "~> 1.2"
  gem "capybara"
  gem "selenium-webdriver", "~> 2.41"
  gem "capybara-webkit"
end

group :production do
  gem "rails_12factor"
  gem "puma"
  gem "unicorn"

  gem "fog"
end

group :doc do
  gem "sdoc", require: false
end

gem "annotate", ">=2.6.0"
