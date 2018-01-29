# frozen_string_literal: true

require 'rails_helper'
require 'support/calculation_helper'

describe Reports::CalculationRateItem do
  let(:rates_data) { test_rates }
  let(:calculation) { test_calculation }
  let(:calculation_rate) { Reports::CalculationRate.new(calculation) }
  let(:date) { Date.parse(rates_data.keys.sample) }
  let(:calculation_rate_item) do
    Reports::CalculationRateItem.new(calculation_rate, date.to_s)
  end
  let(:items) do
    Reports::CalculationRateItem.from_calculation(calculation_rate)
  end

  describe 'rate items' do
    it 'returns correct number of items (rates_date size + today)' do
      expect(items.size).to eq(rates_data.size + 1)
    end
    it 'returns array of CalculationRateItem' do
      expect(items).to all(be_an(Reports::CalculationRateItem))
    end
  end
end
