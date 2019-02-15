Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'sessions#new'
  get '/signup', to: 'users#new'
  resources :users
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
