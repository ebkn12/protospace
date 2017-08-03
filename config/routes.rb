Rails.application.routes.draw do
  devise_for :users
  resources :prototypes, only: %i[index show new]
  root 'prototypes#index'
end
