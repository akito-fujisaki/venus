# frozen_string_literal: true

require 'test_helper'

module TweetsTest
  # DestroyTest
  class DestroyTest < ActionDispatch::IntegrationTest
    test 'when tweet is not found' do
      delete '/tweets/1'
      assert_equal(
        { status: 'not_found', message: "Couldn't find Tweet with 'id'=1" },
        parse_response_body
      )
    end

    test 'when tweet is found' do
      created_response = create_tweet({ message: 'test' })
      tweet_id = created_response[:id]

      delete "/tweets/#{tweet_id}"
      assert_equal({ status: 'ok', message: 'deleted' }, parse_response_body)

      get "/tweets/#{tweet_id}"
      assert_equal(
        { status: 'not_found', message: "Couldn't find Tweet with 'id'=#{tweet_id}" },
        parse_response_body
      )
    end
  end
end
