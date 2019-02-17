Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'sessions#new'
  # sets the /signup page to the page for creating a new user
  get '/signup', to: 'users#new'
  resources :users
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :organisations
  resources :shifts
end
