Rails.application.routes.draw do
  devise_for :users
  root to: 'countries#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :countries, only: [:index, :show] do
    resources :reviews, only: [:create]
    resources :alerts, only: [:create]
    collection do
      get :compare
    end
  end

  resources :alerts, only: [:index, :destroy]
  resources :reviews, only: [:destroy]

  # # compare route
  # get "countries/compare", to: "countries#compare", as: "compare"

end
