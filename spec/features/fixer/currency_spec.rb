# frozen_string_literal: true

require 'rails_helper'
require 'support/currency_helper'

describe Fixer::Currency do
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
  it 'returns empty hash if number of weeks is incorrect' do
    VCR.use_cassette('eur_to_rur_conversion_incorrect_weeks', vcr_options) do
      rates = currency.rates(-1)
      expect(rates.size).to eq(0)
      expect(rates.keys).to eq([])
      expect(rates.values.size).to eq(0)
    end
  end
end
