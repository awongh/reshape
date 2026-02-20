# frozen_string_literal: true

require 'spec_helper'

describe Reshape::Client do
  it 'should instantiate with consumer key and consumer secret' do
    expect do
      Reshape::Client.new({
                            consumer_token: ENV.fetch('SHAPEWAYS_CONSUMER_TOKEN', nil),
                            consumer_secret: ENV.fetch('SHAPEWAYS_CONSUMER_SECRET', nil),
                            oauth_token: ENV.fetch('SHAPEWAYS_OAUTH_TOKEN', nil),
                            oauth_secret: ENV.fetch('SHAPEWAYS_OAUTH_SECRET', nil)
                          })
    end.not_to raise_exception
  end

  describe 'api_endpoint' do
    after(:each) do
      Reshape.reset
    end

    it 'should default to https://api.shapeways.com/' do
      client = Reshape::Client.new
      expect(client.api_endpoint).to eq 'https://api.shapeways.com/'
    end

    it 'should be set' do
      Reshape.api_endpoint = 'http://foo.dev'
      client = Reshape::Client.new
      expect(client.api_endpoint).to eq 'http://foo.dev/'
    end
  end

  describe 'web_endpoint' do
    after(:each) do
      Reshape.reset
    end

    it 'should default to http://www.shapeways.com/' do
      client = Reshape::Client.new
      expect(client.web_endpoint).to eq 'http://www.shapeways.com/'
    end

    it 'should be set' do
      Reshape.web_endpoint = 'http://foo.dev'
      client = Reshape::Client.new
      expect(client.web_endpoint).to eq 'http://foo.dev/'
    end
  end
end
