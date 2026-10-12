source "https://rubygems.org"

ruby "4.0.6"

gem "rails", "~> 8.1.3"
gem "fiddle"
gem "pg", "~> 1.7"
gem "propshaft"    
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"
gem "bootsnap", require: false

# Authentication
gem "devise", "~> 5.0"

# Pagination
gem "kaminari", "~> 1.2"

# Image processing for Active Storage
gem "image_processing", "~> 1.2"

group :development, :test do
  gem "debug", platforms: %i[mri windows]
  gem "faker", "~> 3.2"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

gem "tzinfo-data", platforms: %i[windows jruby]

# Fix JSON.parse compatibility issue
gem "json", "< 3.0"
