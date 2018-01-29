# frozen_string_literal: true

def test_rates
  { '2018-01-29' => 1.2239,
    '2018-02-05' => 1.2277,
    '2018-02-12' => 1.1973,
    '2018-02-19' => 1.1993,
    '2018-02-26' => 1.1853 }
end

def test_calculation
  Calculation.new(base_currency: 'EUR',
                  target_currency: 'USD',
                  amount: 17_000, max_weeks: 5,
                  rates_data: rates_data,
                  created_at: '2018-01-28 17:53:30',
                  rate_on_create: 1.2436,
                  updating_by_job: true)
end

def test_rates_values
  [test_calculation.rate_on_create] + test_rates.values
end

def test_chart_data_profit
  { name: 'Profit', data: { '2018-01-28' => 0.0,
                            '2018-01-29' => -334.9,
                            '2018-02-05' => -270.3,
                            '2018-02-12' => -787.1,
                            '2018-02-19' => -753.1,
                            '2018-02-26' => -991.1 } }
end

def test_chart_data_rate
  { name: 'Rate', data: { '2018-01-28' => 1.2436,
                          '2018-01-29' => 1.2239,
                          '2018-02-05' => 1.2277,
                          '2018-02-12' => 1.1973,
                          '2018-02-19' => 1.1993,
                          '2018-02-26' => 1.1853 } }
end
