# frozen_string_literal: true

require 'spec_helper'

describe Reshape::Client::Price do
  let(:client) do
    shapeways_client
  end

  after(:each) do
    shapeways_client.reset
  end

  it 'should list cart orders in json' do
    VCR.use_cassette('price') do
      response = client.price(0.000001, 0.0006, 0, 0.01, 0, 0.01, 0, 0.01)
      expect(response).to be_an_instance_of(Hashie::Mash)
      expect(response.result).to eq 'success'
    end
  end
end
