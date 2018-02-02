# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CurrenciesUpdateJob, type: :job do
  describe '#perform_later' do
    it 'updates calculation rates' do
      user = create(:user)
      c = Calculation.new(base_currency: 'EUR',
                          target_currency: 'USD',
                          amount: 10_000,
                          max_weeks: 5,
                          user: user)
      ActiveJob::Base.queue_adapter = :test
      expect do
        CurrenciesUpdateJob.perform_later(c.id)
      end.to have_enqueued_job
    end
  end
end
