# frozen_string_literal: true

#
#  Exchange Calculations
#
class Calculation < ApplicationRecord
  validates :base_currency,
            :target_currency,
            :amount,
            :max_weeks, presence: true
  validates :max_weeks, numericality: { only_integer: true }
  validates :base_currency, :target_currency,
            inclusion: { in: Fixer::API::ALLOWED_CURRENCIES }
  before_save :update_rates

  def rates_report
    Reports::CalculationRate.new(self).rates
  end

  def rates_chart
    Reports::CalculationRate.new(self).chart
  end

  private

  def update_rates
    remote_currency = Fixer::Currency.new(target_currency, base: base_currency)
    self.rate_on_create = Fixer::API.value_for_date(base_currency,
                                                    target_currency,
                                                    Date.today)
    self.rates_data = remote_currency.rates(max_weeks)
  rescue StandardError => e
    errors.add(rates_data: e)
  end
end
