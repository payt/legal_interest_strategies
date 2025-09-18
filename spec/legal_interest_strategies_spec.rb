require_relative "../lib/legal_interest_strategies"

RSpec.describe LegalInterestStrategies do
  describe ".for_country" do

    it "loads strategies for NL" do
      data = LegalInterestStrategies.for_country("NL")
      expect(data["country_code"]).to eq("NL")
      expect(data["strategies"]).to be_an(Array)
    end

    context "when the country file does not exist" do
      it "raises an error" do
        expect { LegalInterestStrategies.for_country("XX") }.to raise_error(LegalInterestStrategies::CountryNotFound)
      end
    end
  end

  describe ".business_strategy_for" do
    it "returns the business strategy for NL" do
      strategy = LegalInterestStrategies.business_strategy_for("NL")
      expect(strategy).to be_a(Hash)
      expect(strategy["business"]).to be true
      expect(strategy["rates"]).to be_an(Array)
    end

    context "when there is no business strategy" do
      it "returns nil" do
        allow(LegalInterestStrategies).to receive(:for_country).with("NL").and_return({
          "country_code" => "NL",
          "strategies" => [
            { "consumer" => true, "rates" => [] }
          ]
        })
        strategy = LegalInterestStrategies.business_strategy_for("NL")
        expect(strategy).to be_nil
      end
    end
  end

  describe ".consumer_strategy_for" do
    it "returns the consumer strategy for NL" do
      strategy = LegalInterestStrategies.consumer_strategy_for("NL")
      expect(strategy).to be_a(Hash)
      expect(strategy["consumer"]).to be true
      expect(strategy["rates"]).to be_an(Array)
    end
  end
end
