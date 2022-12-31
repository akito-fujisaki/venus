# frozen_string_literal: true

require 'test_helper'

module TweetsTest
  # UpdateTest
  class UpdateTest < ActionDispatch::IntegrationTest
    test 'when tweet is not found' do
      get '/tweets/1'

      assert_equal(
        { status: 'not_found', message: "Couldn't find Tweet with 'id'=1" },
        parse_response_body
      )
    end

    test 'when params is valid' do
      created_response = create_tweet({ message: 'test' })
      tweet_id = created_response[:id]

      put "/tweets/#{tweet_id}", params: { message: 'updated' }

      assert_response :success
      assert_equal 'updated', parse_response_body[:message]
    end

    test 'when params is invalid' do
      created_response = create_tweet({ message: 'test' })
      tweet_id = created_response[:id]

      put "/tweets/#{tweet_id}", params: { message: '' }
      assert_equal(
        { status: 'unprocessable_entity', message: "Validation failed: Message can't be blank" },
        parse_response_body
      )

      get "/tweets/#{tweet_id}"
      assert_equal created_response, parse_response_body
    end
  end
end
