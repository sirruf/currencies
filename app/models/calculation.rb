# frozen_string_literal: true

#
#  Exchange Calculations
#
class Calculation < ApplicationRecord
  validates :base_currency,
            :target_currency,
            :amount,
            :max_weeks, presence: true
  validates :amount, numericality: { only_integer: true,
                                     greater_than_or_equal_to: 1,
                                     less_than_or_equal_to: 100_000 }
  validates :max_weeks, numericality: { only_integer: true,
                                        greater_than_or_equal_to: 1,
                                        less_than_or_equal_to: 10 }
  validates :base_currency, :target_currency,
            inclusion: { in: Fixer::API::ALLOWED_CURRENCIES }
  attr_accessor :updating_by_job

  after_commit :update_rates

  def data_ready?
    rates_data.present?
  end

  def rates_report
    Reports::CalculationRate.new(self).rates
  end

  def rates_chart
    Reports::CalculationRate.new(self).chart
  end

  private

  def update_rates
    CurrenciesUpdateJob.perform_later(id) unless updating_by_job
  end
end
