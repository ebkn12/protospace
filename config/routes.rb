Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[edit update show]
  resources :prototypes
  root 'prototypes#index'
end
