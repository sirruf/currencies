# frozen_string_literal: true

describe Fixer::API do
  it 'returns rate for date' do
    VCR.use_cassette('eur_to_usd_conversion_for_date') do
      date = Date.strptime('2009-31-05', '%Y-%d-%m')
      value = Fixer::API.value_for_date('EUR', 'USD', date)
      expect(value).to eq(1.4098)
    end
  end
end
