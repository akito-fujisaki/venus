# frozen_string_literal: true

require 'test_helper'

module TweetsTest
  # CreateTest
  class CreateTest < ActionDispatch::IntegrationTest
    test 'when params is valid' do
      before_count = Tweet.count

      post '/tweets', params: { message: 'test' }

      tweet = Tweet.last

      assert_equal before_count + 1, Tweet.count
      assert_equal TweetSerializer.to_json(tweet), @response.body
      assert_equal 'test', parse_response_body[:message]
    end

    test 'when params is invalid' do
      before_count = Tweet.count

      assert_raises(ActiveRecord::RecordInvalid) do
        post '/tweets', params: { message: '' }
      end

      assert_equal before_count, Tweet.count
    end
  end
end
