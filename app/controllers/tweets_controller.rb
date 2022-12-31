# frozen_string_literal: true

# TweetsController
class TweetsController < ApplicationController
  # @return [String]
  def index
    render json: '[]'
  end
end
