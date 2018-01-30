# frozen_string_literal: true

require 'rails_helper'
require 'support/shared/calculation_shared'

describe Calculation, type: :model do
  context 'Validations' do
    it 'validates the required parameters' do
      should validate_presence_of(:base_currency)
      should validate_presence_of(:target_currency)
      should validate_presence_of(:amount)
      should validate_presence_of(:max_weeks)
    end

    it 'validates that amount in the range between 1 to 100000' do
      should validate_numericality_of(:amount).is_greater_than_or_equal_to(1)
      should validate_numericality_of(:amount).is_less_than_or_equal_to(100_000)
    end

    it 'validates that max_weeks in the range between 1 to 250' do
      should validate_numericality_of(:max_weeks).is_greater_than_or_equal_to(1)
      should validate_numericality_of(:max_weeks).is_less_than_or_equal_to(250)
    end

    it 'validates that currencies values in an allowed list' do
      allowed_curr = Fixer::API::ALLOWED_CURRENCIES
      should validate_inclusion_of(:base_currency).in_array(allowed_curr)
      should validate_inclusion_of(:target_currency).in_array(allowed_curr)
    end
  end
end

describe Calculation, type: :model do
  context 'public methods' do
    include_context 'shared test rates'
    include_context 'shared test calculation'
    include_context 'shared test charts'

    let(:rates_data) { test_rates }
    let(:calculation) { test_calculation }
    let(:calculation_wo_rates) { test_calculation_wo_rates }
    it 'returns correct data_ready' do
      expect(calculation.data_ready?).to eq(true)
      expect(calculation_wo_rates.data_ready?).to eq(false)
    end
    it 'returns correct rates_report' do
      rates = calculation.rates_report
      expect(rates.map(&:value)).to eq(test_rates_values)
    end
    it 'returns correct rates_chart' do
      expect(calculation.rates_chart).to eq([test_chart_data_profit, test_chart_data_rate])
    end
  end
end
