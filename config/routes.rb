Rails.application.routes.draw do
  root 'pages#home'
  get "signin" => "sessions#new"
  post "signin" => "sessions#create"
  delete "signout" => "sessions#destroy"
  get "signup" =>  "users#new"
  resources :users, except: [:new]
  resources :messages


end
