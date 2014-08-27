# This is the HeisenBugDev Gemfile. All assets should be handled through here.
#
# If you are setting up for development you should run:
#   `bundle install --without production`
# That will prevent you from having to deal with the postgres gem
#
# Please keep this Gemfile organized and do not add gems that only add a few
# lines of code.

source 'https://rubygems.org'
source 'https://rails-assets.org'

ruby '2.1.1'

# Gems that are required for every environment

gem 'rails', '4.0.3'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'foundation-rails', '~> 5.2'
gem 'haml-rails'
gem 'puma'

gem 'pry-byebug'

# We will remove this when we rewrite the rasterizer
gem "mini_magick"

gem 'carrierwave'
gem 'devise'
gem 'omniauth-github'

# Do we want to get rid of this as a dependency?
gem 'simple_token_authentication'

gem 'cancancan', '~> 1.7'
gem "rolify"

# This will be removed when it is replaced by ember
gem 'rails3-jquery-autocomplete'

# This _may_ be removed soon
gem 'jquery-ui-rails'

gem 'will_paginate'
gem 'github-markdown', :require => 'github/markdown'

gem 'ember-rails'
gem 'ember-source', '1.6.0.beta.2'
gem "active_model_serializers"
gem 'emblem-rails'
gem 'colorize'
gem 'friendly_id', '~> 5.0.0'
gem 'bourbon'
gem 'neat'
gem 'rack-mini-profiler'
gem 'octokit'

# Aviators
gem "aviators", :github => 'HeisenBugDev/aviators', :branch => 'master'

# Rails-assets
# You can add any bower package using this. Simply add the gem as:
# rails-assets-BOWER_PACKAGE_NAME
gem 'rails-assets-ember-uploader'

# All gems that are only used in production
group :production do
  gem 'pg'
  gem "bugsnag"
  gem 'newrelic_rpm'
  gem 'fog', '~> 1.22.0'
  gem 'rails_12factor'
end

# All gems that are only used in development.
group :development do
  gem 'bullet'
  gem 'sqlite3'
  gem 'jazz_hands'
  gem 'railroady'
  gem 'dotenv-rails'
  gem 'rubocop'
  gem "annotate", "~> 2.6.2"
  gem 'better_errors'
  gem 'binding_of_caller', :platforms => [:mri_19, :mri_20, :rbx]
  gem 'guard-bundler'
  gem 'guard-redis'
  gem 'guard-rspec'
  gem 'guard-rails'
  gem 'html2haml'
  gem 'rails_layout'
  gem 'rb-fchange', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-inotify', :require => false
end

# All gems that are only used in development and test.
group :development, :test do
  gem 'faker'
  gem 'rspec-rails'
  gem "shoulda-matchers", "~> 2.5.0"
end

# All gems that are only used in test.
group :test do
  gem 'factory_girl_rails'
  gem 'coveralls', require: false
  gem 'capybara'
  gem 'database_cleaner', '~> 1.2'
  gem 'email_spec'
  gem 'launchy'
end
