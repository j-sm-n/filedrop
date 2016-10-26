Rails.application.routes.draw do

  root "home#index"

  get '/users/verify', to: 'verification#new', as: 'verify'
  post '/users/verify', to: 'verification#create'
  post '/users/resend'

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
    resources :users, only:[:index, :update]
  end


  resources :documents, only:[:index] #TODO move this?
  resources :users, only:[:new, :create, :edit, :update, :show] do
    resources :documents, only:[:new, :create, :show]
    scope module: 'users' do
      resources :folders, only:[:new, :create, :index, :edit, :update]
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
