# frozen_string_literal: true

# GenericResponseSerializer
class GenericResponseSerializer < BaseSerializer
  # @return [Hash<Symbol, Object>]
  def to_h
    {
      status: object[:status],
      message: object[:message]
    }
  end
end
