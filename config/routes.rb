# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"
  get "/auth/:provider/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout
  get "/auth/failure" => "sessions#failure"

  get "/account" => "home#account"
  resources :playlists, only: %i[show destroy]
  namespace :playlists do
    resource :import, only: [:create]
  end
end
