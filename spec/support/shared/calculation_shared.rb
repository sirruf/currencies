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

shared_context 'shared calculation params' do
  let(:calc_params) do
    { calculation: { base_currency: 'EUR',
                     target_currency: 'USD',
                     amount: 10_000,
                     max_weeks: 5 } }
  end
end
