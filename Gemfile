source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.1.6'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
group :development do
  gem "capistrano"
  gem 'capistrano-rails'
  gem "capistrano-rbenv"
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# bootstrap
gem 'bootstrap3-rails'
gem 'twitter-bootstrap-rails'
gem 'font-awesome-rails'
gem 'less-rails'
gem 'simple_form'

# devise
gem 'devise'
gem 'devise-bootstrap-views'

# test
group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem "factory_bot_rails"
  gem 'faker'
  gem 'guard-rspec'
  gem 'database_rewinder'
  gem 'rspec-request_describer'
  gem 'autodoc'
  gem 'json_spec'
  gem 'hpricot'
  gem 'rubocop-rspec'
  gem 'rails-controller-testing'
end

# haml
gem 'haml-rails'

# production
group :production do
  gem 'mysql2', '0.3.18'
end

# html
gem 'liquid'
gem 'jquery-ace-rails'

# autocomplete
gem 'rails4-autocomplete'

# breadcrumbs
gem 'gretel'

# config
gem 'config'

# tuning
group :development do
  gem 'rack-mini-profiler'
  gem 'peek'
  gem 'peek-rblineprof'
  gem 'bullet'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'
end

#gem 'rake', '< 11.0'
#gem 'ffi', '~> 1.9.24'
#gem 'nokogiri', '~> 1.8.2'

