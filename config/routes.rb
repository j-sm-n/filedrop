Rails.application.routes.draw do

  root "home#index"

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :comments, only: [:create, :index, :show]
    end
  end

  get '/users/verify', to: 'verification#new', as: 'verify'
  post '/users/verify', to: 'verification#create'
  post '/users/resend'
  post '/notification', to: 'notification#create'
  put '/notification', to: 'notification#update'
  delete '/notification', to: 'notification#destroy'
  get '/api_request', to: 'external_application#index'

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
    resources :comments, only: [:new, :create, :destroy, :edit, :update]
  end

  resources :folders, only:[:index, :show, :update]
  resources :downloads, only:[:create]

  get '/dashboard', to: 'dashboard#index'
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete '/logout', to: 'sessions#destroy'
  get '/:user_name', to: 'users#show'

end
