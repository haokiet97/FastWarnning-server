Rails.application.routes.draw do
  devise_for :users
  root to: "static_pages#index"
  resources :cameras do
    resources :photos
    resources :videos
  end

  resources :photos
  resources :videos
  resource :users, only: %i(show), as:  "profile"

  namespace :api  do
    resources :cameras, only: %i() do
      resources :photos, only: %i(create)
      resources :videos, only: %i(create)
    end
  end
end
