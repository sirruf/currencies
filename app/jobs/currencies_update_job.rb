# frozen_string_literal: true

#
#  Job for currencies rates update
#
class CurrenciesUpdateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    c = Calculation.find(args[0])
    return unless c.present?
    remote_currency = Fixer::Currency.new(c.target_currency,
                                          base: c.base_currency)
    c.rate_on_create = Fixer::API.value_for_date(c.base_currency,
                                                 c.target_currency,
                                                 Date.today)
    c.update_attributes(updating_by_job: true,
                        rates_data: remote_currency.rates(c.max_weeks))
  end
end
