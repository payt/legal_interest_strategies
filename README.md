# Legal interest strategies

Provides the legal interest for several countries

### .for_country

Returns the complete strategy information for a given country code (ISO 3166-2).

```ruby
country_code = "NL"
LegalInterestStrategies.for_country(country_code)
```

### .business_rates_for_country

Returns the business interest rates for a given country code (ISO 3166-2).

```ruby
country_code = "NL"
LegalInterestStrategies.business_rates_for_country(country_code)
```

### .consumer_rates_for_country

Returns the consumer interest rates for a given country code (ISO 3166-2).

```ruby
country_code = "NL"
LegalInterestStrategies.consumer_rates_for_country(country_code)
```

### TODO

- Add more countries

### Testing

- Run the tests: `bundle exec rspec`
