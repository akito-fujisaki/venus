# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'debug'

# IntegrationTestHelper
module IntegrationTestHelper
  # @param response_body [String]
  # @return [Hash<Symbol, Object>]
  def parse_response_body
    JSON.parse(@response.body, symbolize_names: true)
  end

  # @param params [Hash<Symbol, Object>]
  # @return [Hash<Symbol, Object>]
  def create_tweet(params)
    post '/tweets', params: params
    parse_response_body
  end
end

# ActionDispatch::IntegrationTest
class ActionDispatch::IntegrationTest
  include IntegrationTestHelper
end
