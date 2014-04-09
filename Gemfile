source 'https://rubygems.org'
ruby '2.1.1'
gem 'rails', '4.0.3'
gem 'sqlite3'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'foundation-rails', '~> 5.2'
gem 'haml-rails'
gem 'unicorn'
gem 'unicorn-rails'
gem "mini_magick"
gem 'carrierwave'
gem "sidekiq", "~> 2.17.7"
gem "sidetiq", "~> 0.5.0"
gem "sinatra", "~> 1.4.4"
gem 'devise'
gem 'omniauth-github'
gem 'simple_token_authentication'
gem 'cancancan', '~> 1.7'
gem "rolify"
gem 'rails3-jquery-autocomplete'
gem 'jquery-ui-rails'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'railroady'
  gem 'binding_of_caller'
  gem 'dotenv-rails'
  gem 'rubocop'
  gem "annotate", "~> 2.6.2"
  gem 'ruby_gntp'
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'guard-bundler'
  gem 'guard-cucumber'
  gem 'guard-redis'
  gem 'guard-rspec'
  gem 'guard-rails'
  gem 'guard-livereload', require: false
  gem 'html2haml'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
end

group :development, :test do
  gem 'rspec-rails'
  gem "shoulda", "~> 3.5.0"
end

group :test do
  gem 'factory_girl_rails'
  gem 'coveralls', require: false
  gem 'capybara'
  gem 'cucumber-rails', :require=>false
  gem 'database_cleaner', '~> 1.2'
  gem 'email_spec'
  gem 'launchy'
end
