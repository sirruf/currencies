# frozen_string_literal: true

module Fixer
  #
  #  Currency rates data from API
  #
  class Currency
    MAX_WEEKS = 25
    attr_reader :rates_values

    def initialize(target, options = { base: 'EUR' })
      @target = target
      @base = options[:base]
      @rates_values = {}
    end

    def rates(weeks)
      wks = weeks.to_i <= MAX_WEEKS ? weeks.to_i : MAX_WEEKS
      generator = DatesGenerator.new(wday_number: 1)
      past_dates = generator.dates_for(wks, past: true)
      future_dates = generator.dates_for(wks)
      @rates_values = get_rates(past_dates, future_dates)
    end

    private

    def get_rates(past_dates, future_dates, with_past = false)
      all_rates = {}
      past_dates.each_with_index do |date, index|
        # value = API.value_for_date(@base, @target, date)
        value = rate_by_date(date)
        unless value.nil?
          all_rates[date.to_s] = value if with_past
          all_rates[future_dates[future_dates.size - index - 1].to_s] = value
        end
      end
      all_rates.sort.to_h
    end

    def rate_by_date(date)
      rate = Rate.find_by(base: @base, target: @target, rate_date: date)
      if rate.present?
        rate.value
      else
        value = API.value_for_date(@base, @target, date)
        Rate.create(base: @base, target: @target, rate_date: date, value: value)
        value
      end
    end
  end
end
