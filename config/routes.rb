Rails.application.routes.draw do
  root      'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'connect' => 'static_pages#connect_storage'
  get 'callback' => 'static_pages#callback'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  namespace :api, defaults:{format: 'json'} do
      post 'login' => 'pictures#login'
      post 'logout' => 'pictures#logout'
      resources :pictures
  end
end
