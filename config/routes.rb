Rails.application.routes.draw do

  get 'utils/erd', to: 'utils#erd'

  resources :scores
  resources :persons
  resources :users
  resources :sessionyears do
    resources :registrations
  end
  resources :registrations

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  # Sessions / login
  resources :sessions
  get  'calendar/:id', to: 'sessionyears#calendar'
  post 'calendar/:id', to: 'sessionyears#calendar'

  root :to => 'persons#index'
end

