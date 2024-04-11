Rails.application.routes.draw do
  get "home" => 'pages#home'
  get "signin" => "sessions#new"
  post "signin" => "sessions#create"
  delete "signout" => "sessions#destroy"
  get "signup" =>  "users#new"
  resources :users, except: [:new]
  get 'profile/:id', to: 'users#profile', as: 'profile'
  get 'profile/:id/edit', to: 'users#edit', as: 'edit_profile'
  patch 'profile/:id/edit', to: 'users#update', as: 'update_profile'

  
  resources :groups do
    resources :messages
  end
  
  root "groups#index"
    

end
