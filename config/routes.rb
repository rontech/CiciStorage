Rails.application.routes.draw do
  get 'pictures/create'

  get 'pictures/create'

  get 'password_resets/new'

  get 'password_resets/edit'

  root      'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
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
