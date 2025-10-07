# frozen_string_literal: true

require "yaml"

module LegalInterestStrategies
  class CountryNotFound < StandardError; end

  def self.for_country(country_code)
    path = File.expand_path("legal_interest_strategies/data/strategies/#{country_code}.yml", __dir__)

    raise CountryNotFound, "No strategy found for country code: #{country_code}" unless File.exist?(path)

    YAML.safe_load_file(path, permitted_classes: [Date], symbolize_names: true)
  end

  def self.business_rates_for_country(country_code)
    data = for_country(country_code)
    data[:strategies].find { |strategy| strategy[:business] }.fetch(:rates, nil)
  end

  def self.consumer_rates_for_country(country_code)
    data = for_country(country_code)
    data[:strategies].find { |strategy| strategy[:consumer] }.fetch(:rates, nil)
  end
end
