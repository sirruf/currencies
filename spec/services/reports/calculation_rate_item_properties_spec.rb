# frozen_string_literal: true

require 'rails_helper'
require 'support/shared/calculation_shared'

describe Reports::CalculationRateItem do
  include_context 'shared test rates'
  include_context 'shared test calculation'

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

  describe 'properties' do
    it 'returns correct properties' do
      sum = (calculation.amount * rates_data[date.to_s]).round(4)
      profit = (sum - (calculation.amount * calculation.rate_on_create))
               .round(4)
      expect(calculation_rate_item.value).to eq(rates_data[date.to_s])
      expect(calculation_rate_item.week).to eq(date.cweek)
      expect(calculation_rate_item.year).to eq(date.year)
      expect(calculation_rate_item.in_past?).to eq(date.past?)
      expect(calculation_rate_item.sum).to eq(sum)
      expect(calculation_rate_item.profit).to eq(profit)
    end
  end
end
