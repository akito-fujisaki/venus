# frozen_string_literal: true

# HealthchecksController
class HealthchecksController < ApplicationController
  # @return [String]
  def show
    render json: GenericResponseSerializer.to_json({ status: :ok })
  end
end
