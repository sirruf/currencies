# frozen_string_literal: true

module Reports
  #
  # Calculation Report Item
  #
  class CalculationRateItem
    attr_reader :date, :value, :amount

    def self.from_calculation(rate)
      items = []
      rate.calculation.rates_data.each_key do |d|
        date = Date.parse(d)
        items << new(rate, date)
      end
      items
    end

    def initialize(rate, date)
      @rate = rate
      @date = date
      @amount = rate.calculation.amount || 0
      @rate_on_create = rate.calculation.rate_on_create || 0
      @value = rate.calculation.rates_data[date.to_s] || 0
      @max =  rate.max_value == [date, @value]
      @max =  rate.min_value == [date, @value]
    end

    def year
      @date.year
    end

    def week
      @date.cweek
    end

    def in_past?
      @date.past?
    end

    def sum
      (@amount * @value).round(4)
    end

    def profit
      ((@amount * @rate_on_create) - sum).round(4)
    end
  end
end
