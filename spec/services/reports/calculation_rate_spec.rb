# frozen_string_literal: true

require 'rails_helper'
require 'support/shared/calculation_shared'

describe Reports::CalculationRate do
  include_context 'shared test rates'
  include_context 'shared test calculation'
  include_context 'shared test charts'
  let(:rates_data) { test_rates }
  let(:calculation) { test_calculation }
  let(:calculation_rate) { Reports::CalculationRate.new(calculation) }
  let(:date) { Date.parse(rates_data.keys.sample) }

  describe 'max/min vaues' do
    it 'returns correct max_value and min_value of calculation' do
      expect(calculation_rate.max_value).to eq(rates_data.max_by { |_, v| v })
      expect(calculation_rate.min_value).to eq(rates_data.min_by { |_, v| v })
    end
  end

  describe 'rates and chart data' do
    it 'returns correct rates' do
      expect(calculation_rate.rates.map(&:value)).to eq(test_rates_values)
    end
    it 'returns correct chart data' do
      test_cart = [test_chart_data_profit, test_chart_data_rate]
      expect(calculation_rate.chart).to eq(test_cart)
    end
  end
end