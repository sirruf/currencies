# frozen_string_literal: true

module Reports
  #
  # Calculation Report Item
  #
  class CalculationRateItem
    attr_reader :date, :value, :amount, :max_value, :min_value

    def self.from_calculation(rate)
      items = [new(rate, rate.calculation.created_at.to_date)]
      return [items] unless rate.calculation.rates_data.present?
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
      set_values
    end

    def year
      @date.to_date.year
    end

    def week
      @date.to_date.cweek
    end

    def in_past?
      @date.to_date.past?
    end

    def sum
      (@amount * @value).round(4)
    end

    def profit
      (sum - (@amount * @rate_on_create)).round(4)
    end

    private

    def set_values
      @rate_on_create = @rate.calculation.rate_on_create || 1
      @max_value = max_value?
      @min_value = min_value?
      @value = value_for(@date, @rate)
    end

    def value_for(date, rate)
      @value = if rate.calculation.rates_data.present?
                 rate.calculation.rates_data[date.to_s] || @rate_on_create
               else
                 @rate_on_create
               end
    end

    def max_value?
      @rate.max_value && @rate.max_value[1] == @value
    end

    def min_value?
      @rate.min_value && @rate.min_value[1] == @value
    end
  end
end
