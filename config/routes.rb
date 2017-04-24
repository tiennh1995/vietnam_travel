Rails.application.routes.draw do
  root "pages#show"
  devise_for :users
  resources :images do
    resources :comments
  end
  resources :comments do
    resources :reply_comments
  end
  resources :popular_images
  resources :follow_users
end
