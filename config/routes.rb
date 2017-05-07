Rails.application.routes.draw do
  root "pages#show"
  devise_for :users, controllers: {
    registrations: "registrations",
  }
  resources :images do
    resources :comments, except: :show
    resources :likes, only: [:create, :destroy]
  end
  resources :comments do
    resources :reply_comments, except: :show
  end
  resources :popular_images
  resources :follow_users, only: :index
  resources :users, only: [:show, :update]

  resources :likes
end
