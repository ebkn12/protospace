Rails.application.routes.draw do
  devise_for :users
  resource :users, only: %i[edit update]
  resources :users, only: :show

  namespace :prototypes do
    resources :popular, only: :index
    resources :tags, param: :tag_name, only: %i[index show]
  end
  resources :prototypes do
    resources :comments, only: :create
    resource :likes, only: %i[create destroy], as: :like
  end

  root 'prototypes#index'
end
