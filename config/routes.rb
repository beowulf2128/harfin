Rails.application.routes.draw do

  resources :persons
  resources :users

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  # Sessions / login
  resources :sessions

  root :to => 'persons#index'
end

