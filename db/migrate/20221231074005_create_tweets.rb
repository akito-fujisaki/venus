# frozen_string_literal: true

# CreateTweet
class CreateTweets < ActiveRecord::Migration[7.0]
  # @return [void]
  def change
    create_table :tweets, comment: 'ツイート' do |t|
      t.string :message, null: false, limit: 255, comment: '本文'
      t.timestamps
    end
  end
end
