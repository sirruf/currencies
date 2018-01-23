# frozen_string_literal: true

module Fixer
  #
  #  Data from API
  #
  class API
    BASE_URL = 'https://api.fixer.io/'
    ALLOWED_CURRENCIES = %w[AUD BGN BRL CAD CHF CNY CZK
                            DKK EUR GBP HKD HRK HUF IDR
                            ILS INR JPY KRW MXN MYR NOK
                            NZD PHP PLN RON RUB SEK SGD
                            THB TRY USD ZAR].freeze
    class << self
      def value_for_date(base, target, date)
        res = Fixer::API::Request.get(date.to_s, base: base, symbols: target)
        JSON.parse(res.body).symbolize_keys[:rates][target] \
          if res.is_a?(Net::HTTPSuccess)
      end
    end
  end
end
