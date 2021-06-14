Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users
  root to: 'countries#index'
  # root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :countries, only: [:index, :show] do
    resources :reviews, only: [:create, :show]
    resources :alerts, only: [:create]
    collection do
      get :compare      
    end
    member do
      get :explore
    end
  end

  resources :alerts, only: [:index, :destroy]
  resources :reviews, only: [:destroy]
  resources :users, only: [:show]
end
