# frozen_string_literal: true

require 'rails_helper'
require 'support/shared/calculation_shared'

describe Reports::CalculationRate do
  include_context 'shared test rates'
  include_context 'shared test charts'
  let(:rates_data) { test_rates }
  let(:calc) do
    create(:calculation, user: create(:user), rates_data: rates_data)
  end
  let(:calc_rate) { Reports::CalculationRate.new(calc) }
  let(:calc_rate_values) { [calc.rate_on_create] + test_rates.values }

  let(:date) { Date.parse(rates_data.keys.sample) }

  describe 'max/min vaues' do
    it 'returns correct max_value and min_value of calculation' do
      expect(calc_rate.max_value).to eq(rates_data.max_by { |_, v| v })
      expect(calc_rate.min_value).to eq(rates_data.min_by { |_, v| v })
    end
  end

  describe 'rates and chart data' do
    it 'returns correct rates' do
      expect(calc_rate.rates.map(&:value)).to eq(calc_rate_values)
    end
    it 'returns correct chart data' do
      test_cart = [test_chart_data_profit, test_chart_data_rate]
      expect(calc_rate.chart).to eq(test_cart)
    end
  end
end
