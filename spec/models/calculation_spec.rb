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
    include_context 'shared test charts'

    let(:user) { create(:user) }
    let(:rates_data) { test_rates }
    let(:calc) do
      create(:calculation, user: user, rates_data: rates_data)
    end
    let(:rates_values) { [calc.rate_on_create] + rates_data.values }
    let(:calc_wo_rates) { create(:calculation, user: user) }
    it 'returns correct data_ready' do
      expect(calc.data_ready?).to eq(true)
      expect(calc_wo_rates.data_ready?).to eq(false)
    end
    it 'returns correct rates_report' do
      rates = calc.rates_report
      expect(rates.map(&:value)).to eq(rates_values)
    end
    it 'returns correct rates_chart' do
      expect(calc.rates_chart).to eq([test_chart_data_profit,
                                      test_chart_data_rate])
    end
  end
end
