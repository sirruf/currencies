# frozen_string_literal: true

require 'rails_helper'

shared_context 'shared test rates' do
  let(:test_rates) do
    { '2018-01-29' => 1.2239,
      '2018-02-05' => 1.2277,
      '2018-02-12' => 1.1973,
      '2018-02-19' => 1.1993,
      '2018-02-26' => 1.1853 }
  end

  let(:test_rates_values) do
    [test_calculation.rate_on_create] + test_rates.values
  end
end

shared_context 'shared test calculation' do
  let(:test_calculation) do
    Calculation.new(base_currency: 'EUR',
                    target_currency: 'USD',
                    amount: 17_000, max_weeks: 5,
                    rates_data: rates_data,
                    created_at: '2018-01-28 17:53:30',
                    rate_on_create: 1.2436,
                    updating_by_job: true)
  end
  let(:test_calculation_wo_rates) do
    Calculation.new(base_currency: 'EUR',
                    target_currency: 'USD',
                    amount: 17_000, max_weeks: 5,
                    rates_data: nil,
                    created_at: '2018-01-28 17:53:30',
                    rate_on_create: 1.2436,
                    updating_by_job: true)
  end
end

shared_context 'shared test charts' do
  let(:test_chart_data_profit) do
    { name: 'Profit', data: { '2018-01-28' => 0.0,
                              '2018-01-29' => -334.9,
                              '2018-02-05' => -270.3,
                              '2018-02-12' => -787.1,
                              '2018-02-19' => -753.1,
                              '2018-02-26' => -991.1 } }
  end
  let(:test_chart_data_rate) do
    { name: 'Rate', data: { '2018-01-28' => 1.2436,
                            '2018-01-29' => 1.2239,
                            '2018-02-05' => 1.2277,
                            '2018-02-12' => 1.1973,
                            '2018-02-19' => 1.1993,
                            '2018-02-26' => 1.1853 } }
  end
end
