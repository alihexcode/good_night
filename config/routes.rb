# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    resources :users, only: [:index] do
      resources :sleep_records, only: [:index, :create]
      resources :friends, only: [:index, :show] do
        get :sleep_records, on: :collection
      end
      delete 'friendships/:friend_id/unfriend', to: 'friendships#unfriend'
      post 'friendships/:friend_id/add_friend', to: 'friendships#add_friend'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
