require "yaml"

module LegalInterestStrategies
  class CountryNotFound < StandardError; end

  def self.for_country(country_code)
    path = File.expand_path("legal_interest_strategies/data/strategies/#{country_code}.yml", __dir__)

    unless File.exist?(path)
      raise CountryNotFound, "No strategy found for country code: #{country_code}"
    end

    YAML.load_file(path)
  end

  def self.business_strategy_for(country_code)
    data = for_country(country_code)
    data["strategies"].find { |strategy| strategy["business"] }
  end

  def self.consumer_strategy_for(country_code)
    data = for_country(country_code)
    data["strategies"].find { |strategy| strategy["consumer"] }
  end
end

