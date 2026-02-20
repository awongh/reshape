# frozen_string_literal: true

require 'spec_helper'

describe Reshape::Client::Orders do
  let(:client) do
    shapeways_client
  end

  after(:each) do
    shapeways_client.reset
  end

  it 'should list cart orders in json' do
    VCR.use_cassette('cart') do
      response = client.cart
      expect(response).to be_an_instance_of(Hashie::Mash)
      expect(response.result).to eq 'success'
    end
  end

  it 'should add an order to the cart in json' do
    VCR.use_cassette('add_to_cart') do
      response = client.add_to_cart(212_594, 77, 1)
      expect(response).to be_an_instance_of(Hashie::Mash)
      expect(response.result).to eq 'success'
    end
  end
end
