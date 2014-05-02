Rails.application.routes.draw do
  root to: 'goals#index'
  resources :users, only: [:new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :goals
end


