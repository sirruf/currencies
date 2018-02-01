# frozen_string_literal: true

require 'rails_helper'
require 'support/shared/calculation_shared'

describe Reports::CalculationRateItem do
  include_context 'shared test rates'

  let(:rates_data) { test_rates }
  let(:calc) do
    create(:calculation, user: create(:user), rates_data: rates_data)
  end
  let(:c_rate) { Reports::CalculationRate.new(calc) }
  let(:date) { Date.parse(rates_data.keys.sample) }
  let(:calc_rate_item) { Reports::CalculationRateItem.new(c_rate, date.to_s) }
  let(:items) { Reports::CalculationRateItem.from_calculation(c_rate) }

  describe 'properties' do
    it 'returns correct properties' do
      sum = (calc.amount * rates_data[date.to_s]).round(4)
      profit = (sum - (calc.amount * calc.rate_on_create))
               .round(4)
      expect(calc_rate_item.value).to eq(rates_data[date.to_s])
      expect(calc_rate_item.week).to eq(date.cweek)
      expect(calc_rate_item.year).to eq(date.year)
      expect(calc_rate_item.in_past?).to eq(date.past?)
      expect(calc_rate_item.sum).to eq(sum)
      expect(calc_rate_item.profit).to eq(profit)
    end
  end
end
