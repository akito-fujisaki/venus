# frozen_string_literal: true

# ErrorsController
class ErrorsController < ApplicationController
  # @return [Hash<Integer, Symbol>]
  STATUS_CODE_TO_SYMBOL = Rack::Utils::SYMBOL_TO_STATUS_CODE.invert.freeze
  private_constant :STATUS_CODE_TO_SYMBOL
  # @return [Array<Class>]
  ALLOW_MESSAGE_CLASSES = [
    ActiveRecord::RecordNotFound,
    ActiveRecord::RecordInvalid
  ].freeze
  private_constant :ALLOW_MESSAGE_CLASSES

  # @return [String]
  def show
    exception = request.env['action_dispatch.exception']
    message = ALLOW_MESSAGE_CLASSES.include?(exception.class) ? exception.message : ''
    status = STATUS_CODE_TO_SYMBOL[Integer(request.path[1..])]

    render json: GenericResponseSerializer.to_json({ status: status, message: message }),
           status: status
  end
end
