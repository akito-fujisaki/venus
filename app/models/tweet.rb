# frozen_string_literal: true

# Tweet
class Tweet < ApplicationRecord
  attribute :message, :string, default: ''

  validates :message, presence: true, length: { maximum: 255 }
end
