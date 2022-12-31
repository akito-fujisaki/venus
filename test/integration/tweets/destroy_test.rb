# frozen_string_literal: true

require 'test_helper'

module TweetsTest
  # DestroyTest
  class DestroyTest < ActionDispatch::IntegrationTest
    test 'when tweet is not found' do
      assert_raises(ActiveRecord::RecordNotFound) do
        delete '/tweets/1'
      end
    end

    test 'when tweet is found' do
      created_response = create_tweet({ message: 'test' })
      tweet_id = created_response[:id]

      delete "/tweets/#{tweet_id}"

      assert_equal({ status: 'ok', message: 'deleted' }, parse_response_body)
      assert_raises(ActiveRecord::RecordNotFound) do
        get "/tweets/#{tweet_id}"
      end
    end
  end
end
