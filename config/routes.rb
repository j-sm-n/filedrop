Rails.application.routes.draw do

  root "home#index"

  get '/users/verify', to: 'users#show_verify', as: 'verify'
  post 'users/verify'
  post 'users/resent'

  resources :documents, only:[:index]
  resources :users, only:[:new, :create, :edit, :update, :show] do
    resources :folders, only:[:new, :create]
  end

  resources :folders, only:[:index, :show]

  get '/dashboard', to: 'dashboard#index'
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete '/logout', to: 'sessions#destroy'

end
