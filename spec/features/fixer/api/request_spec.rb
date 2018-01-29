# frozen_string_literal: true

require 'rails_helper'

describe Fixer::API::Request do
  let(:date) { Date.strptime('2009-31-05', '%Y-%d-%m').to_s }
  it 'returns rate for date with correct params' do
    VCR.use_cassette('eur_to_usd_conversion_for_date') do
      date = Date.strptime('2009-31-05', '%Y-%d-%m').to_s
      response = Fixer::API::Request.get(date, base: 'EUR', symbols: 'USD')
      expect(response.code).to eq('200')
      expect(response.body).to eq('{"base":"EUR","date":"2009-05-29","rates":{"USD":1.4098}}')
    end
  end
  it 'returns rate for date with incorrect date' do
    VCR.use_cassette('eur_to_usd_conversion_with_incorrect_date') do
      response = Fixer::API::Request.get('terfd', base: 'EUR', symbols: 'USD')
      expect(response.code).to eq('404')
      expect(response.body).to eq('{"error":"Not found"}')
    end
  end
  it 'returns rate for date with nil date' do
    VCR.use_cassette('eur_to_usd_conversion_with_nil_date') do
      response = Fixer::API::Request.get(nil, base: 'EUR', symbols: 'USD')
      expect(response.code).to eq('200')
      expect(response.body).to eq('{"details":"http://fixer.io"}')
    end
  end
end
