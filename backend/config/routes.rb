# frozen_string_literal: true

Rails.application.routes.draw do
  resource :healthcheck, only: :show

  resources :tweets, only: %i[index show create update destroy]
end
