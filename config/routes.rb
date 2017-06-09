Rails.application.routes.draw do
  root "pages#show"
  devise_for :users, controllers: {
    registrations: "registrations"
  }
  patch "password", to: "passwords#update"
  get "edit_password", to: "passwords#edit"
  get "new_password", to: "passwords#new"
  resources :passwords
  resources :images do
    resources :comments, except: :show
    resources :likes, only: [:create, :destroy]
    resources :book_marks, only: [:create, :destroy]
    resources :reports, only: :create
    resources :shares, except: [:index, :show, :destroy]
  end
  resources :comments, only: :index do
    resources :reply_comments, except: :show
  end
  resources :popular_images, only: :index
  resources :follow_users, only: :index
  resources :users, only: [:show, :edit, :update] do
    resources :book_marks, only: :index
    resources :relationships, only: [:create, :destroy]
  end
  resources :searches, only: :index
end
