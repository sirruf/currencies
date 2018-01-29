# frozen_string_literal: true

require 'rails_helper'
require 'support/calculation_helper'

describe Reports::CalculationRate do
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
      expect(calculation_rate.rates.map(&:value)).to eq(test_rates_values_with_today)
    end
    it 'returns correct chart data' do
      expect(calculation_rate.chart).to eq([test_chart_data_profit, test_chart_data_rate])
    end
  end
end
