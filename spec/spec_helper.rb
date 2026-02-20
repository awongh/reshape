# frozen_string_literal: true

unless ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec'
  end
end

require 'reshape'
require 'rspec'
require 'webmock/rspec'
require 'vcr'
require 'debug'
require 'oauth2'
require 'dotenv/load'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.allow_http_connections_when_no_cassette = true
end

def a_get(url)
  a_request(:get, shapeways_url(url))
end

def a_post(url)
  a_request(:post, shapeways_url(url))
end

def a_put(url)
  a_request(:put, shapeways_url(url))
end

def a_delete(url)
  a_request(:delete, shapeways_url(url))
end

def stub_get(url)
  stub_request(:get, shapeways_url(url))
end

def stub_post(url)
  stub_request(:post, shapeways_url(url))
end

def stub_put(url)
  stub_request(:put, shapeways_url(url))
end

def stub_delete(url)
  stub_request(:delete, shapeways_url(url))
end

def fixture_path
  File.expand_path('../fixtures', __dir__)
end

def fixture(file)
  File.new("#{fixture_path}/#{file}")
end

def shapeways_url(url)
  "https://api.shapeways.com/#{url}/#{@client.api_version}"
end

def shapeways_client
  Reshape::Client.new({
                        consumer_token: ENV.fetch('SHAPEWAYS_CONSUMER_TOKEN', nil),
                        consumer_secret: ENV.fetch('SHAPEWAYS_CONSUMER_SECRET', nil),
                        oauth_token: ENV.fetch('SHAPEWAYS_OAUTH_TOKEN', nil),
                        oauth_secret: ENV.fetch('SHAPEWAYS_OAUTH_SECRET', nil)
                      })
end

def shapeways_oauth_client
  key = ENV.fetch('SHAPEWAYS_CONSUMER_TOKEN', nil)
  secret = ENV.fetch('SHAPEWAYS_CONSUMER_SECRET', nil)

  client = OAuth2::Client.new(key, secret, site: 'https://api.shapeways.com', token_url: '/oauth2/token')

  access = client.client_credentials.get_token

  token = access.token

  Reshape::Client.new({
                        consumer_token: nil,
                        consumer_secret: nil,
                        oauth_token: token,
                        oauth_secret: nil
                      })
end
