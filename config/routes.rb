Rails.application.routes.draw do
  get "home" => 'pages#home'
  get "signin" => "sessions#new"
  post "signin" => "sessions#create"
  delete "signout" => "sessions#destroy"
  get "signup" =>  "users#new"
  resources :users, except: [:new]
  resources :groups do
    resources :messages
  end
  
  root "groups#index"
    

end
