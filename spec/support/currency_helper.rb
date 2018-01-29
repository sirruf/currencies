# frozen_string_literal: true

def number_of_weeks
  3
end

def currency
  Fixer::Currency.new('USD')
end

def rates
  currency.rates(number_of_weeks)
end

def dates
  DatesGenerator.new.dates_for(number_of_weeks)
end

def vcr_options
  { record: :new_episodes }
end
