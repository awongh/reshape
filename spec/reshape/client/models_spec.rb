# frozen_string_literal: true

require 'spec_helper'

describe Reshape::Client::Models do
  let(:client) do
    shapeways_client
  end

  after(:each) do
    shapeways_client.reset
  end

  it 'should list models in json' do
    VCR.use_cassette('models') do
      response = client.models
      expect(response).to be_an_instance_of(Hashie::Mash)
      expect(response.result).to eq 'success'
    end
  end

  it 'should return model details in json' do
    VCR.use_cassette('model') do
      response = client.model(1_114_694)
      expect(response).to be_an_instance_of(Hashie::Mash)
      expect(response.result).to eq 'success'
      expect(response.modelId).to eq '1114694'
    end
  end

  it 'should add a new model' do
    skip 'Need to add STL file to fixtures'
  end

  it 'should delete the model details in json' do
    skip 'Need to record deletion of a specific model id'
  end

  it 'should return info about a specific model in json' do
    VCR.use_cassette('model_info') do
      response = client.model_info(1_114_694)
      expect(response).to be_an_instance_of(Hashie::Mash)
      expect(response.result).to eq 'success'
      expect(response.modelId).to eq '1114694'
    end
  end

  it 'should update model info' do
    VCR.use_cassette('update_model_info') do
      response = client.update_model_info(1_114_694, { description: 'USB thingy' })
      expect(response).to be_an_instance_of(Hashie::Mash)
      expect(response.result).to eq 'success'
      expect(response.description).to eq 'USB thingy'
    end
  end

  it 'should add a file to the model' do
    skip 'Need to add STL file to fixtures'
  end

  it 'should return a model file by a specific version number' do
    VCR.use_cassette('model_file_by_version') do
      response = client.model_file_by_version(1_114_694, '1')
      expect(response).to be_an_instance_of(Hashie::Mash)
      expect(response.result).to eq 'success'
      expect(response.modelVersion).to eq '1'
    end
  end

  it 'should add a photo to the model' do
    skip 'Need to add JPG file to fixtures'
  end
end
