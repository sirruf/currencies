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

    def chart
      build_chart_data([
                         line('Profit', :profit),
                         # line('Sum', :sum),
                         line('Rate', :value)
                       ])
    end

    # private

    def build_chart_data(lines = [])
      rates.each do |item|
        lines.each do |line|
          line[:line_hash][:data][item.date.to_s] = item.send(line[:method])
        end
      end
      lines.map { |l| l[:line_hash] }
    end

    def line(name, method)
      { line_hash: { name: name, data: {} }, method: method }
    end
  end
end
