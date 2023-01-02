# frozen_string_literal: true

# BaseSerializer
class BaseSerializer
  class << self
    # @param object [Object]
    # @return [String]
    def to_json(object)
      JSON.generate(to_h(object))
    end

    # @param objects [Enumerable]
    # @return [String]
    def repeated_json(objects)
      objects.map { to_h(_1) }.then { JSON.generate(_1) }
    end

    private

    # @param object [Object]
    # @return [Hash<Symbol, Object>]
    def to_h(object)
      new(object).to_h
    end
  end

  # @param object [Object]
  # @return [void]
  def initialize(object)
    @object = object
  end

  private

  # @!attribute [r] object
  # @return [Object]
  attr_reader :object

  # @return [Hash<Symbol, Object>]
  def to_h
    raise NotImplementedError
  end

  # @param value [ActiveSupport::TimeWithZone, nil]
  # @return [String, nil]
  def datetime_string(value)
    value&.then { _1.strftime('%FT%T.%6N%:z') }
  end
end
