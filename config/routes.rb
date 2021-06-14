Rails.application.routes.draw do
  get 'posts/index'
  get 'posts/new'
  get 'posts/create'
  get 'posts/show'
  get 'posts/edit'
  get 'posts/update'
  root 'static#home'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users, only: [:show] do
    resources :posts, only: [:index, :edit, :update]
    resources :subscriptions, only: [:index, :edit, :update]
  end

  resources :subscriptions

  resources :groups
  resources :groups, only: [:show] do
    resources :posts, only: [:new, :show, :create]
  end

  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
