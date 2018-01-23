# frozen_string_literal: true

#
# Range of Dates generator
#
class DatesGenerator
  def initialize(options = {})
    @day_number = options[:wday_number] || 1
  end

  def dates_for(number_of_weeks = 1, options = {})
    @past = options[:past] ? options[:past] : false
    start_date = start_date(number_of_weeks)
    end_date = end_date(number_of_weeks)
    (start_date..end_date).to_a.select \
          { |k| k.wday == @day_number }
  end

  private

  def start_date(number_of_weeks)
    @past ? (Date.today - number_of_weeks.weeks) : Date.today
  end

  def end_date(number_of_weeks)
    @past ? Date.today : (Date.today + number_of_weeks.weeks)
  end
end
