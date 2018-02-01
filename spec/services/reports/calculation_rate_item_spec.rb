# frozen_string_literal: true

require 'rails_helper'
require 'support/shared/calculation_shared'

describe Reports::CalculationRateItem do
  include_context 'shared test rates'
  let(:rates_data) { test_rates }
  let(:calc) do
    create(:calculation, user: create(:user), rates_data: rates_data)
  end
  let(:calc_rate) { Reports::CalculationRate.new(calc) }
  let(:date) { Date.parse(rates_data.keys.sample) }
  let(:calc_rate_item) do
    Reports::CalculationRateItem.new(calc_rate, date.to_s)
  end
  let(:items) do
    Reports::CalculationRateItem.from_calculation(calc_rate)
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
