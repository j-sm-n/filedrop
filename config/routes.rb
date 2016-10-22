Rails.application.routes.draw do

  root "home#index"

<<<<<<< HEAD
  resources :documents, only:[:index]

  resources :users, only:[:new, :create, :edit, :update] do
    resources :folders, only:[:new, :create]
  end

=======
>>>>>>> development
  get '/users/verify', to: 'users#show_verify', as: 'verify'
  post 'users/verify'
  post 'users/resent'

  resources :documents, only:[:index]
  resources :users, only:[:new, :create, :edit, :update, :show]

  get '/dashboard', to: 'dashboard#index'
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete '/logout', to: 'sessions#destroy'

end
