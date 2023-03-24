# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    resources :users, only: [:index] do
      resources :friends, only: [:index, :show] do
        resources :sleep_records, only: [:index]
      end
    end
    resources :friendships, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
