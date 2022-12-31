# frozen_string_literal: true

# TweetsController
class TweetsController < ApplicationController
  # @return [String]
  def index
    render json: TweetSerializer.repeated_json(Tweet.all)
  end

  # @return [String]
  def show
    Tweet.find(tweet_id)
         .then { TweetSerializer.to_json(_1) }
         .then { render json: _1 }
  end

  # @return [String]
  def create
    Tweet.create!(tweet_params)
         .then { TweetSerializer.to_json(_1) }
         .then { render json: _1 }
  end

  # @return [String]
  def update
    Tweet.find(tweet_id)
         .tap { _1.update!(tweet_params) }
         .then { TweetSerializer.to_json(_1) }
         .then { render json: _1 }
  end

  # @return [String]
  def destroy
    Tweet.find(tweet_id).destroy!

    render json: GenericResponseSerializer.to_json({ status: :ok, message: 'deleted' })
  end

  private

  # @return [Integer]
  # @raise [ArgumentError, TypeError]
  def tweet_id
    Integer(params[:id], 10)
  end

  # @return [ActionController::Parameters]
  def tweet_params
    params.permit(:message)
  end
end
