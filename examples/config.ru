# frozen_string_literal: true

require 'bundler/setup'
require 'sinatra/base'
require 'omniauth-shapeways'
require 'reshape'
require 'json'

# Get these keys from http://developer.shapeways.com
ENV['SHAPEWAYS_CONSUMER_KEY'] = ''
ENV['SHAPEWAYS_CONSUMER_SECRET'] = ''

# To run this example:
# $ bundle install
# $ rackup -p 9293 config.ru &

class App < Sinatra::Base
  get '/' do
    redirect '/auth/shapeways'
  end

  get '/auth/:provider/callback' do
    auth = request.env['omniauth.auth']

    client = Reshape::Client.new({
                                   consumer_token: ENV.fetch('SHAPEWAYS_CONSUMER_KEY', nil),
                                   consumer_secret: ENV.fetch('SHAPEWAYS_CONSUMER_SECRET', nil),
                                   oauth_token: auth.credentials.token,
                                   oauth_secret: auth.credentials.secret
                                 })

    materials = client.materials

    erb "<h1>#{params[:provider]}</h1>
         <pre>#{JSON.pretty_generate(auth)}</pre>
         <pre>#{JSON.pretty_generate(materials)}</pre>"
  end

  get '/auth/failure' do
    JSON.generate(request.env.select { |_k, v| v.is_a?(String) })
  end
end

use Rack::Session::Cookie

use OmniAuth::Builder do
  provider :shapeways, ENV.fetch('SHAPEWAYS_CONSUMER_KEY', nil), ENV.fetch('SHAPEWAYS_CONSUMER_SECRET', nil)
end

run App.new
