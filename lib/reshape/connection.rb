# frozen_string_literal: true

require 'faraday'
require 'faraday/mashify'
require 'faraday/response/raise_reshape_api_error'

module Reshape
  module Connection
    private

    def connection(raw = false, _force_urlencoded = false)
      url = Reshape.api_endpoint.to_s

      options = {
        url: url,
        proxy: proxy,
        ssl: { verify: false }
      }

      Faraday.new(options) do |builder|
        builder.use Faraday::Response::RaiseReshapeApiError

        builder.request :json
        builder.request :authorization, 'Bearer', @oauth_token

        builder.response :logger

        connection_options.each { |op, v| builder.options[op] = v }

        unless raw
          builder.response :mashify
          builder.response :json
        end

        builder.adapter(*adapter)
      end
    end
  end
end
