Rails.application.routes.draw do
  get "login" => "sessions#new"
  get "signup" =>  "users#new"
  resources :users, except: [:new]
end
