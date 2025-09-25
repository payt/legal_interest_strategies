# frozen_string_literal: true

require_relative "../lib/legal_interest_strategies"

RSpec.describe LegalInterestStrategies do
  let(:country_code) { "NL" }

  describe ".for_country" do
    subject(:for_country) { described_class.for_country(country_code) }

    it "loads strategies for NL" do
      expect(for_country).to include("country_code" => "NL", "strategies" => an_instance_of(Array))
    end

    context "when no country file exists for the given country_code" do
      let(:country_code) { "XX" }

      it "raises an error" do
        expect { for_country }.to raise_error(LegalInterestStrategies::CountryNotFound)
      end
    end
  end

  describe ".business_rates_for_country" do
    subject(:business_rates_for_country) { described_class.business_rates_for_country(country_code) }

    it "returns a hash with rates" do
      expect(business_rates_for_country).to all(be_a(Hash))
    end

    it "returns the right last business strategy rate" do
      expect(business_rates_for_country.last).to eq({ "from_date" => "2025-07-01", "rate" => 10.15 })
    end

    context "when there is no business strategy" do
      before do
        allow(described_class).to receive(:for_country).with(country_code).and_return(
          { "country_code" => country_code, "strategies" => [{ "business" => true }] }
        )
      end

      it "returns nil" do
        expect(business_rates_for_country).to be_nil
      end
    end
  end

  describe ".consumer_rates_for_country" do
    subject(:consumer_rates_for_country) { described_class.consumer_rates_for_country(country_code) }

    it "returns a hash with rates" do
      expect(consumer_rates_for_country).to all(be_a(Hash))
    end

    it "returns the right last consumer strategy rate" do
      expect(consumer_rates_for_country.last).to eq({ "from_date" => "2025-01-01", "rate" => 6.0 })
    end

    context "when there is no consumer strategy" do
      before do
        allow(described_class).to receive(:for_country).with(country_code).and_return(
          { "country_code" => country_code, "strategies" => [{ "consumer" => true }] }
        )
      end

      it "returns nil" do
        expect(consumer_rates_for_country).to be_nil
      end
    end
  end
end
