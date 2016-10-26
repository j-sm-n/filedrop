Rails.application.routes.draw do

  root "home#index"

  get '/users/verify', to: 'verification#new', as: 'verify'
  post '/users/verify', to: 'verification#create'
  post '/users/resend'
  post '/notification', to: 'notification#create'
  put '/notification', to: 'notification#update'
  get '/api_request', to: 'external_application#index'

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
    resources :users, only:[:index, :update]
  end


  resources :documents, only:[:index]
  resources :users, only:[:new, :create, :edit, :update, :show] do
    resources :documents, only:[:new, :create]
    scope module: 'users' do
      resources :folders, only:[:new, :create, :index]
    end
    resources :comments, only: [:new, :create]
  end

  resources :folders, only:[:index, :show]
  resources :downloads, only:[:create]

  get '/dashboard', to: 'dashboard#index'
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete '/logout', to: 'sessions#destroy'

end
