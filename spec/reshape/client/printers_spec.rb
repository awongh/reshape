# frozen_string_literal: true

require 'spec_helper'

describe Reshape::Client::Printers do
  let(:client) do
    shapeways_client
  end

  after(:each) do
    shapeways_client.reset
  end

  it 'should list printers in json' do
    VCR.use_cassette('printers') do
      response = client.printers
      expect(response).to be_an_instance_of(Hashie::Mash)
      expect(response.result).to eq 'success'
      expect(response.printers).to be_a_kind_of(Array)
    end
  end

  it 'should return specific printer info in json' do
    VCR.use_cassette('printer') do
      response = client.printer(8)
      expect(response).to be_an_instance_of(Hashie::Mash)
      expect(response.result).to eq 'success'
      expect(response.title).to eq 'SLS Color Printer'
    end
  end
end
