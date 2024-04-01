Rails.application.routes.draw do
  get "signin" => "sessions#new"
  post "signin" => "sessions#create"
  delete "signout" => "sessions#destroy"
  get "signup" =>  "users#new"
  resources :users, except: [:new,:show]
  get 'users/:username', to: 'users#show', as: :user_by_username
end
