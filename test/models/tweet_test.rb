# frozen_string_literal: true

require "test_helper"

# TweetTest
class TweetTest < ActiveSupport::TestCase
  test 'when message is empty string' do
    tweet = Tweet.new(message: '')
    assert tweet.invalid?
    assert_equal({ message: ["can't be blank"] }, tweet.errors.messages)
  end

  test 'when message is 255 characters' do
    assert_changes -> { Tweet.count }, from: 0, to: 1 do
      Tweet.create!(message: 'a' * 255)
    end
  end

  test 'when message is 256 characters' do
    tweet = Tweet.new(message: 'a' * 256)
    assert tweet.invalid?
    assert_equal({ message: ['is too long (maximum is 255 characters)'] }, tweet.errors.messages)
  end
end
