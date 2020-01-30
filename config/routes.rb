Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :update, :destroy] do
    member do
      get :following, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end
  resources :posts, only: [:new, :create, :show, :edit, :update, :destroy] do
  	resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  get '/timeline', to: 'posts#index', as: :timeline do
    resource :favorites, only: [:create, :destroy]
  end
  root 'home#top'
  get '/about', to: 'home#about', as: :about
  get '/list', to: 'home#list', as: :list
end