# frozen_string_literal: true

# GenericResponseSerializer
class GenericResponseSerializer < BaseSerializer
  # @return [Hash<Symbol, Object>]
  def to_h
    {
      status: object.fetch(:status),
      message: String(object[:message])
    }
  end
end
