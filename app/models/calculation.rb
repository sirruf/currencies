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
                                        less_than_or_equal_to: 25 }
  validates :base_currency, :target_currency,
            inclusion: { in: Fixer::API::ALLOWED_CURRENCIES }
  validate :target_and_base_not_eq

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

  def target_and_base_not_eq
    errors.add(:target_currency, "can't be eq base currency") unless
        base_currency != target_currency
  end

  def update_rates
    CurrenciesUpdateJob.perform_later(id) unless updating_by_job
  end
end
