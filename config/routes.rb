Rails.application.routes.draw do
  devise_for :users
  root to: "static_pages#index"
  resources :cameras do
    resources :photos
  end
  resources :photos

  scope :api do
    resources :cameras do
      resources :photos, only: %i(create)
    end
  end
end
