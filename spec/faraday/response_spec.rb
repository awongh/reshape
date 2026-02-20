# frozen_string_literal: true

require 'spec_helper'

describe Faraday::Response do
  before do
    @client = Reshape::Client.new({
                                    consumer_token: ENV.fetch('SHAPEWAYS_CONSUMER_TOKEN', nil),
                                    consumer_secret: ENV.fetch('SHAPEWAYS_CONSUMER_SECRET', nil),
                                    oauth_token: ENV.fetch('SHAPEWAYS_OAUTH_TOKEN', nil),
                                    oauth_secret: ENV.fetch('SHAPEWAYS_OAUTH_SECRET', nil),
                                    proxy: 'http://localhost:8888'
                                  })
  end

  {
    400 => Reshape::BadRequest,
    401 => Reshape::Unauthorized,
    403 => Reshape::Forbidden,
    404 => Reshape::NotFound,
    406 => Reshape::NotAcceptable,
    422 => Reshape::UnprocessableEntity,
    500 => Reshape::InternalServerError,
    502 => Reshape::BadGateway,
    503 => Reshape::ServiceUnavailable
  }.each do |status, exception|
    context "when HTTP status is #{status}" do
      before do
        stub_get('orders/cart').to_return(status: status)
      end

      it "should raise #{exception.name} error" do
        expect do
          @client.cart
        end.to raise_error(exception)
      end
    end
  end
end
