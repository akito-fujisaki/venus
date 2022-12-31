# frozen_string_literal: true

# TweetSerializer
class TweetSerializer < BaseSerializer
  # @return [Hash<Symbol, Object>]
  def to_h
    {
      id: object.id,
      message: object.message,
      created_at: datetime_string(object.created_at),
      updated_at: datetime_string(object.updated_at)
    }
  end
end
