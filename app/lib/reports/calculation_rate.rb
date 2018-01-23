# frozen_string_literal: true

module Reports
  #
  #  Calculation rates
  #
  class CalculationRate
    attr_reader :calculation

    def initialize(calculation)
      @calculation = calculation
    end

    def max_value
      return unless @calculation.rates_data.present?
      @calculation.rates_data.max_by { |_, v| v }
    end

    def min_value
      return unless @calculation.rates_data.present?
      @calculation.rates_data.min_by { |_, v| v }
    end

    def rates
      CalculationRateItem.from_calculation(self)
    end
  end
end
