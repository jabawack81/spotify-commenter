# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"
  get "invite/:invite_code" => "home#invite", as: :invite
  get "/auth/:provider/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout
  get "/auth/failure" => "sessions#failure"
  get "/login", to: "sessions#new"

  get "/account" => "home#account"
  resources :playlists, only: %i[index show destroy] do
    resources :allowed_users, only: %i[create destroy], module: "playlists"
    resources :comments, only: %i[create destroy], module: "playlists"
    resources :tracks, only: %i[show], module: "playlists" do
      resources :comments, only: %i[create destroy], module: "tracks"
    end
    collection do
      resource :import, only: %i[create], module: "playlists"
    end
  end
end
