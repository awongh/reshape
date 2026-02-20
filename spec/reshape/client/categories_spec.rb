# frozen_string_literal: true

require 'spec_helper'

describe Reshape::Client::Categories do
  let(:client) do
    shapeways_client
  end

  after(:each) do
    shapeways_client.reset
  end

  it 'should list printers in json' do
    VCR.use_cassette('categories') do
      response = client.categories
      expect(response).to be_an_instance_of(Hashie::Mash)
      expect(response.result).to eq 'success'
    end
  end

  it 'should return specific printer info in json' do
    VCR.use_cassette('category') do
      response = client.category(100)
      expect(response).to be_an_instance_of(Hashie::Mash)
      expect(response.result).to eq 'success'
      expect(response.title).to eq 'Cases'
    end
  end
end
