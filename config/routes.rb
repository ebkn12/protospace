Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[edit update show]
  resources :prototypes do
    resources :comments, only: :create
  end
  post '/:prototype_id/like' => 'likes#like', as: :like
  delete '/:prototype_id/unlike' => 'likes#unlike', as: :unlike
  root 'prototypes#index'
end
