# frozen_string_literal: true

require 'spec_helper'

describe Reshape do
  after do
    Reshape.reset
  end

  describe '.respond_to?' do
    it 'should be true if method exists' do
      expect(Reshape.respond_to?(:new, true)).to be true
    end
  end

  describe '.new' do
    it 'should be a Reshape::Client' do
      expect(Reshape.new).to be_a Reshape::Client
    end
  end
end
