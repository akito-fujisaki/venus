# frozen_string_literal: true

require 'test_helper'

module TweetsTest
  # GetTest
  class GetTest < ActionDispatch::IntegrationTest
    test 'when tweet is not found' do
      get '/tweets/1'

      assert_equal(
        { status: 'not_found', message: "Couldn't find Tweet with 'id'=1" },
        parse_response_body
      )
    end

    test 'when tweet is found' do
      created_response = create_tweet({ message: 'test' })

      get "/tweets/#{created_response[:id]}"

      assert_response :success
      assert_equal created_response, parse_response_body
    end
  end
end
