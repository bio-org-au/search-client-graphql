# frozen_string_literal: true

source 'http://rubygems.org'

gem 'rails', '~> 4.2'
gem 'unf', '0.1.4'
platform :jruby do
  gem 'activerecord-jdbcpostgresql-adapter'
  gem 'jruby-jars', '9.1.5.0'
  gem 'therubyrhino'
  gem 'warbler'
end

platform :mri do
  gem 'pg', '~> 0.15'
  gem 'thin'
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'execjs'
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster.
# Read more: https://github.com/rails/turbolinks
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

group :development, :test do
  platform :jruby do
    gem 'puma'
  end
  platform :mri do
    # Call 'byebug' anywhere in the code to stop execution and get a debugger
    # console
    gem 'byebug'
  end
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  platform :mri do
    gem 'web-console', '~> 2.0'
  end

  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'awesome_print'
  gem 'spring'
end

gem 'bootstrap', '~> 4.0.0.alpha6' # Use Bootstrap 4.
source 'http://insecure.rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.1'
end

# source 'https://rails-assets.org' do
# gem 'rails-assets-tether', '~> 1.1.1'
# end

gem 'activerecord-hierarchical_query',
    require: 'active_record/hierarchical_query'
gem 'acts_as_tree'
gem 'nunes'
gem 'rest-client'
gem 'scenic', '~> 0.3.0'
gem 'statsd-ruby', require: 'statsd'

platform :ruby do
  group :test do
    gem 'mocha', '~> 1.1.0'
  end
end
gem 'simplecov', require: false, group: :test

gem 'httparty'
