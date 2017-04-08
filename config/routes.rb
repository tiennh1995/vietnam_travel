Rails.application.routes.draw do
  root "pages#show"
  devise_for :users
end
