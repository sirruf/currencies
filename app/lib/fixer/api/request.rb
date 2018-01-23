# frozen_string_literal: true

module Fixer
  class API
    #
    #  HTTP Requests
    #
    class Request
      require 'net/http'

      class << self
        def get(url, params = {})
          uri = URI.parse(API::BASE_URL + url)
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true
          uri.query = URI.encode_www_form(params)
          @data = http.get(uri.request_uri)
        end
      end
    end
  end
end
