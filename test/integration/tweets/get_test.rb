# frozen_string_literal: true

require 'test_helper'

module TweetsTest
  class GetTest < ActionDispatch::IntegrationTest
    test 'when tweets are empty' do
      get '/tweets'
      assert_response :success
      assert_equal '[]', @response.body
    end
  end
end
