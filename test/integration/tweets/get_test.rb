# frozen_string_literal: true

require 'test_helper'

module TweetsTest
  # GetTest
  class GetTest < ActionDispatch::IntegrationTest
    test 'when tweet is not found' do
      assert_raises(ActiveRecord::RecordNotFound) do
        get '/tweets/1'
      end
    end

    test 'when tweet is found' do
      created_response = create_tweet({ message: 'test' })

      get "/tweets/#{created_response[:id]}"

      assert_response :success
      assert_equal created_response, parse_response_body
    end
  end
end
