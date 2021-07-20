Rails.application.routes.draw do
  
  root 'static#home'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users, only: [:edit, :update] 
  resources :users, only: [:show, :showself] do
    resources :follows, only: [:index, :create, :destroy]
    resources :subscriptions, only: [:index, :destroy]
    resources :groups, only: :index
  end

  resources :subscriptions

  resources :posts, only: [:show] do
    resources :comments, only: [:show, :new, :create, :destroy]
    resources :likes, only: [:index, :create, :destroy]
  end

  namespace :groups do
    get 'most_subscribers', to: 'most_subscribers'
  end

  resources :groups

  resources :groups, only: [:show] do
    resources :users, only: [:index]
    resources :posts, only: [:new, :show, :edit, :update, :create, :destroy]
    resources :subscriptions, only: [:new, :create, :edit, :update, :destroy]
  end

  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
