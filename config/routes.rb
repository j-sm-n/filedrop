Rails.application.routes.draw do

  root "home#index"

  resources :documents, only:[:index]
  resources :users, only:[:new]

  get "/login", to: "sessions#new"


end
