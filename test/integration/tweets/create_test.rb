# frozen_string_literal: true

require 'test_helper'

module TweetsTest
  # CreateTest
  class CreateTest < ActionDispatch::IntegrationTest
    test 'when params is valid' do
      get '/tweets'
      before_index_response = parse_response_body

      post '/tweets', params: { message: 'test' }
      created_response = parse_response_body
      assert_equal 'test', created_response[:message]

      get '/tweets'

      assert_equal(
        before_index_response + [created_response],
        parse_response_body
      )
    end

    test 'when params is invalid' do
      get '/tweets'
      before_index_response = parse_response_body
      
      post '/tweets', params: { message: '' }
      assert_equal(
        { status: 'unprocessable_entity', message: "Validation failed: Message can't be blank" },
        parse_response_body
      )

      get '/tweets'
      assert_equal before_index_response, parse_response_body
    end
  end
end
