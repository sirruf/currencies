# frozen_string_literal: true

require 'rails_helper'

describe DatesGenerator do
  let(:default_generator) { DatesGenerator.new }
  let(:number_of_weeks) { rand(1..25) }

  it 'returns array of dates' do
    days = default_generator.dates_for(number_of_weeks)
    expect(days).to all(be_an(Date))
    expect(days.size).to eq(number_of_weeks)
  end

  it 'returns array of dates with correct wday' do
    day_of_week = rand(0..6)
    generator = DatesGenerator.new(wday_number: day_of_week)
    days = generator.dates_for(number_of_weeks)
    expect(days.map(&:wday)).to eq(Array.new(number_of_weeks) \
      { day_of_week })
  end

  it 'returns feature dates range' do
    days = default_generator.dates_for(number_of_weeks)
    expect(days.map(&:past?)).not_to include(true)
  end
end
