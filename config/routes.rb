Rails.application.routes.draw do

  resources :persons
  resources :users
  resources :sessionyears
  resources :registrations

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  # Sessions / login
  resources :sessions
  get 'calendar/:id', to: 'sessionyears#calendar'
  post 'sessionyears/:id/generate_calendar', to: 'sessionyears#generate_calendar'

  root :to => 'persons#index'
end

