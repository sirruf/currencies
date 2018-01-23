# frozen_string_literal: true

require 'rails_helper'

describe Fixer::Currency do
  let!(:number_of_weeks) { 3 }
  let!(:pst_dates) { DatesGenerator.new.dates_for(number_of_weeks, past: true) }
  let!(:ftr_dates) { DatesGenerator.new.dates_for(number_of_weeks) }
  let!(:dates) { pst_dates + ftr_dates }
  it 'returns rates if symbol is correct' do
    VCR.use_cassette('eur_to_usd_conversion') do
      c = Fixer::Currency.new('USD')
      rates = c.rates(number_of_weeks)
      expect(rates.size).to eq(dates.size)
      expect(rates.keys).to eq(dates.sort.map(&:to_s))
      expect(rates.values.size).to eq(dates.size)
      expect(rates.values).not_to include(nil)
    end
  end
  it 'returns empty hash if symbol is incorrect' do
    VCR.use_cassette('eur_to_rur_conversion') do
      c = Fixer::Currency.new('RUR')
      rates = c.rates(number_of_weeks)
      expect(rates.size).to eq(0)
      expect(rates.keys).to eq([])
      expect(rates.values.size).to eq(0)
    end
  end
end
