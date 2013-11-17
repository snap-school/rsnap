source 'https://rubygems.org'
gem "bower-rails", "~> 0.5.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.0.1'

# Use postgresql as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby, :require => 'v8'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
gem 'debugger', group: [:development, :test]

# Use haml template
gem "haml", "~> 4.0.3"
gem "haml-rails", "~> 0.4"

# Use boostrap toolkit
gem "bootstrap-sass-rails", "~> 3.0.1.0"
gem "bootstrap_forms", :github=>"gagalago/bootstrap_forms", :branch => "bootstrap3"

# https://github.com/schnawel007/bootstrap3-wysihtml5
# https://github.com/nickl-/bootstrap-wysihtml5

gem "paperclip", "~> 3.0"
gem "paperclip-dropbox", "~> 1.1.7"
gem "rmagick", "~> 2.13.2"

# User authentication
gem "devise", "~> 3.1.1"
gem "omniauth-openid"

group :test do
  gem 'rspec-rails'

  gem "factory_girl_rails", "~> 4.3.0"
  gem 'faker'

  gem 'cucumber-rails', '~> 1.4.0', :require => false
  gem 'database_cleaner', "~> 1.2.0"
  gem "capybara"
  gem 'selenium-webdriver'
end

group :production do
  gem 'rails_12factor'
end

ruby "2.0.0"
