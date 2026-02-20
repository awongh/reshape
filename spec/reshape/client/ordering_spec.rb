# frozen_string_literal: true

require 'spec_helper'

describe Reshape::Client::Orders, feature: true, js: true, vcr: { record: :new_episodes } do
  let(:client) do
    shapeways_oauth_client
  end

  after(:each) do
    Reshape.reset
  end

  it 'should get all orders' do
    VCR.use_cassette('all_orders_ordering') do
      response = client.orders
      expect(response).to be_an_instance_of(Hashie::Mash)
      expect(response.result).to eq 'success'
      expect(response.ordersStatus.size).to be 1
    end
  end

  it 'should get one order' do
    VCR.use_cassette('one_order_ordering') do
      response = client.order(4_654_952)
      expect(response).to be_an_instance_of(Hashie::Mash)
      expect(response.result).to eq 'success'
    end
  end

  it 'should make a test order' do
    VCR.use_cassette('make_test_order_ordering') do
      model_id = '12982554'

      order_details = {
        testMode: 1,
        firstName: 'Alex',
        lastName: 'Hey',
        country: 'US',
        state: 'CA',
        city: 'San Francisco',
        address1: '1250 Market st',
        address2: '#A',
        address3: 'Rafe Records',
        zipCode: '94110',
        phoneNumber: '123456789',
        items: [
          {
            modelId: model_id,
            materialId: '110',
            quantity: 1
          }
        ],
        paymentMethod: 'credit_card',
        shippingOption: 'Cheapest',
        manufacturingSpeed: 'Economy'
      }

      response = client.add_order(order_details)
      expect(response).to eq false
    end
  end
end
