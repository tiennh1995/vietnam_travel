Rails.application.routes.draw do
  root "pages#show"
  devise_for :users, controllers: {
    registrations: "registrations",
  }
  resources :images do
    resources :comments
  end
  resources :comments do
    resources :reply_comments
  end
  resources :popular_images
  resources :follow_users, only: :index
  resources :users, only: [:show, :update]
end
