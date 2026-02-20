# frozen_string_literal: true

require 'reshape/version'
require 'reshape/configuration'
require 'reshape/client'
require 'reshape/error'

module Reshape
  extend Configuration

  class << self
    def new(options = {})
      Reshape::Client.new(options)
    end

    def respond_to?(method, include_private = false)
      new.respond_to?(method, include_private) || super
    end
  end
end
