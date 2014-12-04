source 'http://rubygems.org'

gem 'rails', '~> 4.1.1'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 4.0.1'
  gem 'coffee-rails', '~> 4.0.1'
  gem 'uglifier', '>= 1.3.0'
end

gem 'jquery-rails'
gem 'turbolinks'
gem 'nprogress-rails'
gem 'twitter-bootstrap-rails', :github => 'seyhunak/twitter-bootstrap-rails'
gem 'less-rails'
gem 'therubyracer'

gem 'omniauth'
gem 'omniauth-oauth2'
gem 'oauth2'
gem 'omniauth-gca', github: 'Yasser/omniauth-gca'

gem 'faraday'

group :development, :test do
  gem 'thin'
  gem 'sqlite3'
  gem 'figaro'
  gem 'letter_opener'
end

group :production do
  gem 'pg'
  gem 'unicorn'
  gem 'memcachier'
  gem 'dalli'
  gem 'kgio'
  gem 'rack-cache'
  gem 'newrelic_rpm'
end

group :production, :staging do
  gem 'rails_12factor'
end