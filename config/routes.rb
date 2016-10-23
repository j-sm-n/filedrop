Rails.application.routes.draw do

  root "home#index"

  get '/users/verify', to: 'users#show_verify', as: 'verify'
  post 'users/verify'
  post 'users/resent'

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
    resources :users, only:[:index, :update]
  end

  resources :documents, only:[:index]
  resources :users, only:[:new, :create, :edit, :update, :show] do
    scope module: 'users' do
      resources :folders, only:[:new, :create, :index]
    end
  end

  resources :folders, only:[:index, :show]

  get '/dashboard', to: 'dashboard#index'
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete '/logout', to: 'sessions#destroy'

end
