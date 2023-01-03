# frozen_string_literal: true

require 'test_helper'

module HealthchecksTest
  # ShowTest
  class ShowTest < ActionDispatch::IntegrationTest
    test 'when tweet is not found' do
      get '/healthcheck'

      assert_response :success
      assert_equal({ status: 'ok', message: '' }, parse_response_body)
    end
  end
end
