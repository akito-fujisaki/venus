# frozen_string_literal: true

require 'test_helper'

module TweetsTest
  # UpdateTest
  class UpdateTest < ActionDispatch::IntegrationTest
    test 'when tweet is not found' do
      assert_raises(ActiveRecord::RecordNotFound) do
        put '/tweets/1', params: { message: 'updated' }
      end
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

      assert_raises(ActiveRecord::RecordInvalid) do
        put "/tweets/#{tweet_id}", params: { message: '' }
      end

      get "/tweets/#{tweet_id}"
      assert_equal created_response, parse_response_body
    end
  end
end
