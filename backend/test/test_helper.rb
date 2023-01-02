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
  # NOTE: 本番環境と同等のエラー処理でテストを実行している。デバッグ等でエラーを確認したい場合はtrueに設定すること
  #
  # @return [Boolean]
  @@raise_exception = false

  # @return [Hash<String, Boolean>]
  DEFAULT_EXCEPTION_CONFIG = Rails.application.env_config.slice(
    'action_dispatch.show_detailed_exceptions', 'action_dispatch.show_exceptions'
  ).freeze
  private_constant :DEFAULT_EXCEPTION_CONFIG

  include IntegrationTestHelper

  setup do
    unless @@raise_exception
      Rails.application.env_config['action_dispatch.show_detailed_exceptions'] = false
      Rails.application.env_config['action_dispatch.show_exceptions'] = true
    end
  end

  teardown do
    Rails.application.env_config.merge!(DEFAULT_EXCEPTION_CONFIG)
  end
end
