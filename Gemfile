# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in legal_interest_strategies.gemspec
gemspec

group :development do
  # SECURITY CHECKS
  gem "brakeman", require: false
  gem "bundler-audit", require: false

  gem "pry"
  gem "rspec"
  # NOTE: this version is locked because of local server incompatibility errors.
  gem "rubocop", "1.81.7", require: false
  gem "rubocop-performance"
  gem "rubocop-rspec"

  gem "simplecov", require: false
end
