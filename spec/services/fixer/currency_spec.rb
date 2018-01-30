# frozen_string_literal: true

require 'rails_helper'
require 'support/shared/currency_shared'

describe Fixer::Currency do
  include_context 'shared test currency'
  include_context 'shared vcr options'
  it 'returns rates if symbol is correct' do
    VCR.use_cassette('eur_to_usd_conversion', vcr_options) do
      expect(rates.size).to eq(dates.size)
      expect(rates.keys).to eq(dates.sort.map(&:to_s))
      expect(rates.values.size).to eq(dates.size)
      expect(rates.values).not_to include(nil)
    end
  end
  it 'returns empty hash if symbol is incorrect' do
    VCR.use_cassette('eur_to_rur_conversion', vcr_options) do
      c = Fixer::Currency.new('RUR')
      rates = c.rates(number_of_weeks)
      expect(rates.size).to eq(0)
      expect(rates.keys).to eq([])
      expect(rates.values.size).to eq(0)
    end
  end
end
describe Fixer::Currency do
  include_context 'shared test currency'
  include_context 'shared vcr options'
  it 'returns empty hash if number of weeks is incorrect' do
    VCR.use_cassette('eur_to_rur_conversion_incorrect_weeks', vcr_options) do
      rates = currency.rates(-1)
      expect(rates.size).to eq(0)
      expect(rates.keys).to eq([])
      expect(rates.values.size).to eq(0)
    end
  end
  it 'saves rates to Rate model' do
    VCR.use_cassette('eur_to_gbp_conversion', vcr_options) do
      c = Fixer::Currency.new('GBP')
      rates = c.rates(number_of_weeks)
      rates_in_cache = Rate.where(value: rates.values)
      expect(rates_in_cache.count).to eq(number_of_weeks)
    end
  end
end
