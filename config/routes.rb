Rails.application.routes.draw do
  
  root 'static#home'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users, only: [:edit, :update] 
  resources :users, only: [:show, :showself] do
    resources :follows, only: [:index, :create, :destroy]
    resources :subscriptions, only: [:index, :edit, :update]
  end

  resources :subscriptions

  resources :posts do 
    resources :likes
  end

  resources :groups
  resources :groups, only: [:show] do
    resources :users, only: [:index]
    resources :posts, only: [:new, :show, :create]
    resources :subscriptions, only: [:new, :create]
  end

  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
