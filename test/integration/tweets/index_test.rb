# frozen_string_literal: true

require 'test_helper'

module TweetsTest
  # IndexTest
  class IndexTest < ActionDispatch::IntegrationTest
    test 'when tweets are empty' do
      get '/tweets'
      assert_response :success
      assert_equal '[]', @response.body
    end

    test 'when tweets exists' do
      created_response_one = create_tweet({ message: 'test1' })
      created_response_two = create_tweet({ message: 'test2' })
      
      get '/tweets'

      assert_response :success
      assert_equal [created_response_one, created_response_two], parse_response_body
    end
  end
end
