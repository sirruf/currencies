# frozen_string_literal: true

FactoryBot.define do
  factory :calculation do
    base_currency 'EUR'
    target_currency 'USD'
    amount 17_000
    max_weeks 5
    created_at '2018-01-28 17:53:30'
    rate_on_create 1.2436
    updating_by_job true
  end
end
