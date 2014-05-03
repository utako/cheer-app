Rails.application.routes.draw do
  root to: 'goals#index'
  resources :users, only: [:index, :show, :new, :create, :destroy] do
    resources :comments, only: [:comment, :create, :destroy]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :goals do
    resources :comments, only: [:comment, :create, :destroy]
  end
end


