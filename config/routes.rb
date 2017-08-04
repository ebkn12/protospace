Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[edit update show]
  resources :prototypes, only: %i[index new create show]
  root 'prototypes#index'
end
