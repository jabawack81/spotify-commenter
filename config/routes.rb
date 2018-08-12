# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"
  get "/auth/:provider/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout
  get "/auth/failure" => "sessions#failure"

  get "/account" => "home#account"
  resources :playlists, only: %i[show destroy] do
    resources :comments, only: %i[create destroy], module: "playlists"
    resources :tracks, only: %i[show], module: "playlists" do
      resources :comments, only: %i[create destroy], module: "tracks"
    end
    collection do
      resource :import, only: %i[create], module: "playlists"
    end
  end
end
